require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

#   describe "GET #index" do
#     it "returns http success" do
#       get :index
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "GET #show" do
#     it "returns http success" do
#       get :show
#       expect(response).to have_http_status(:success)
#     end
#   end

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
          expect(response).to redirect_to(product)
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
        
        it "should redirect to beacon page when successful" do
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
