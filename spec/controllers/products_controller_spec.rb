require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  shared_examples_for "does not have permission" do | http_verb, controller_method |
    it "should raise a Pundit exception" do
      expect do
        send(http_verb, controller_method, params: sent_params)
      end.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  shared_examples_for "invalid id" do | http_verb, controller_method |
    it "should raise an ActiveRecord exception" do
      expect do
        send(http_verb, controller_method, params: {id: -1})
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  shared_examples_for "valid id" do
    it "should find the correct product" do
      expect(assigns(:product)).to eql test_product
    end
  end

  describe "GET #index" do
    shared_examples_for "json request" do
      render_views
      let(:json) { JSON.parse(response.body) }
      before :each do
        @test_product = FactoryGirl.create(:product)
        @test_product_2 = FactoryGirl.create(:product, title: "test2", description: "test2 description")
        get :index, format: :json
      end

      it 'returns the listings' do
        expect(json["products"].count).to eql Product.count
        expect(json["products"].collect{|l| l["title"]}).to eq([@test_product.title, @test_product_2.title])
      end
    end

    context "as user" do
      login_user

      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders index template" do
        get :index
        expect(response).to render_template :index
      end

      it "returns products" do
        get :index
        expect(assigns(:products)).to_not be_nil
      end

      it_should_behave_like "json request"
    end

    context "as admin" do
      login_admin

      it "returns all products" do
        FactoryGirl.create(:product)
        get :index
        expect(assigns(:products).count).to eql Product.count
      end

      it_should_behave_like "json request"
    end
  end

  describe "GET #show" do
    shared_examples_for "has appropriate permissions" do
      it_should_behave_like "valid id"

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders show template" do
        expect(response).to render_template :show
      end
    end

    shared_examples_for "html request" do
      before :each do
        get :show, params: {id: @test_product}
      end

      it_should_behave_like "has appropriate permissions" do
        let(:test_product) {@test_product}
      end
    end

    shared_examples_for "json request" do
      render_views
      let(:json) { JSON.parse(response.body) }
      before do
        @promotion = FactoryGirl.create(:promotion)
        @test_product.promotions << @promotion
        @test_product.save
        get :show, format: :json, params: { id: @test_product.id }
      end

      it_should_behave_like "has appropriate permissions" do
        let(:test_product) {@test_product}
      end

      it "returns the product" do
        expect(json["title"]).to eql @test_product.title
      end

      it "displays promotions belonging to product" do
        expect(json["promotions"].count).to eql @test_product.promotions.count
        expect(json["promotions"].collect{|l| l["title"]}).to include @promotion.title
      end
    end

    before :each do
      @test_product = FactoryGirl.create(:product)
    end

    context "logged in as user" do
      login_user

      it_should_behave_like "html request"
      it_should_behave_like "json request"
      it_should_behave_like "invalid id", :get, :show
    end

    context "logged in as admin" do
      login_admin

      it_should_behave_like "html request"
      it_should_behave_like "json request"
      it_should_behave_like "invalid id", :get, :show
    end
  end

#   describe "GET #new" do
#     it "returns http success" do
#       get :new
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "GET #edit" do
#     it "returns http success" do
#       get :edit
#       expect(response).to have_http_status(:success)
#     end
#   end

  describe "POST create" do
    let(:valid_params) { { product: { featured: true, cost: "19.99", title: "test", description: "Test" } } }
    let(:invalid_params) { { product: { featured: true, cost: "19.99", description: "Test" } } }

    context "as user" do
      login_user

      it "should raise an exception if not an admin" do
        expect do
          post :create, params: valid_params
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "user have admin right" do
      login_admin

      context "with valid parameters" do
        it "increases amount of Product by 1" do
          expect {
            post :create, params: valid_params
          }.to change(Product, :count).by(1)
        end

        it "redirects to the new Product after was made" do
          post :create, params: valid_params
          expect(response).to redirect_to Product.last
        end
      end

      context "with invalid parameters" do
        it "does not save new Product" do
          expect{
            post :create, params: invalid_params
          }.to_not change(Product, :count)
        end

        it "re-renders the new method" do
          post :create, params: invalid_params
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'DELETE destroy' do
    context "as user" do
      login_user
      it "should raise an exception if not an admin" do
        product = FactoryGirl.create(:product)
        expect do
          delete :destroy, params: { id: product.id }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "user have admin right" do
      login_admin

      it "should return an ActiveRecord error if the product id does not exist" do
        expect do
          delete :destroy, params: {id: -1}
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      context "with valid id" do
        it "decreases amount of product by 1" do
          product = FactoryGirl.create(:product)
          expect{
            delete :destroy, params: { id: product.id }
          }.to change(Product, :count).by(-1)
        end

        it "redirects to products_url after destroy product" do
          product = FactoryGirl.create(:product)
          post :destroy, params: { id: product.id }
          expect(response).to redirect_to(products_path)
        end
      end
    end
  end

  describe "PUT #update" do
    context "as user" do
      login_user

      it "should raise an exception if not an admin" do
        product = FactoryGirl.create(:product)
        expect do
          put :update, params: { id: product }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "as admin" do
      let (:valid_params) { { featured: true, cost: "13.99", title: "next", description: "next" } }
      let (:invalid_params) { { title: nil } }

      login_admin

      context "valid_params" do
        before(:each) do
          @product = FactoryGirl.create(:product)
          put :update, params: { id: @product.id, product: valid_params }
          @product.reload
        end

        it "should update object paramaters when logged in as admin" do
          expect(@product.title).to eql valid_params[:title]
          expect(@product.description).to eql valid_params[:description]
          expect(@product.cost).to eql valid_params[:cost]
          expect(@product.featured).to eql valid_params[:featured]
        end

        it "should redirect to product page when successful" do
          expect(response).to redirect_to @product
        end
      end

      context "invalid params" do
        before(:each) do
          @product = FactoryGirl.create(:product)
          put :update, params: { id: @product.id, product: invalid_params }
          @product.reload
        end

        it "should not update object paramaters when given invalid parameters" do
          expect(@product.title).to eql "test"
          expect(@product.description).to eql "test"
          expect(@product.cost).to eql "19.99"
          expect(@product.featured).to eql true
        end

        it "should rerender edit page when update unsuccessful" do
          put :update, params: { id: @product.id, product: invalid_params }
          expect(response).to render_template :edit
        end
      end
    end
  end
end
