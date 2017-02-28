require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
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
    it "should find the correct order" do
      expect(assigns(:order)).to eql test_order
    end
  end

  describe "GET #index" do
    before :each do
      @test_order = FactoryGirl.create(:order)
    end
    
    shared_examples_for "html request" do
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      
      it "renders index template" do
        expect(response).to render_template :index
      end

    end
    
    shared_examples_for "json request" do
      render_views
      let(:json) { JSON.parse(response.body) }
      before do
        get :index, format: :json
      end
      
      it "returns amount of orders user has" do
        expect(json["orders"].count).to eql controller.current_user.orders == nil ? 0: controller.current_user.orders.count
      end
    end
    
    context "as user" do
      login_user
      before :each do
        get :index
      end
      
      it_should_behave_like "html request"
      it_should_behave_like "json request"
      
      it "returns 0 orders if user does not belong to any" do
        expect(assigns(:orders).count).to eql 0
      end
    end
    
    context "as user with orders" do
      login_user
      before :each do
        @test_order.user = controller.current_user
        @test_order.save
        get :index
      end
      
      it_should_behave_like "html request"
      it_should_behave_like "json request"
      
      it "returns orders to which user belongs" do
        expect(assigns(:orders).count).to eql subject.current_user.orders.count
        expect(assigns(:orders)).to include subject.current_user.orders.last
      end
    end
    
    context "as admin" do
      login_admin
      
      context "as html request" do
        before :each do
          FactoryGirl.create(:order)
          get :index
        end
        
        it_should_behave_like "html request"
        
        it "returns all orders" do
          expect(assigns(:orders).count).to eql Order.count
        end
      end
      
      context "as json request" do
        render_views
        let(:json) { JSON.parse(response.body) }
        before do
          @test_order2 = FactoryGirl.create(:order)
          get :index, format: :json
        end
        
        it "includes all orders" do
          expect(json["orders"].count).to eql Order.count
          expect(json["orders"].collect{|l| l["id"]}).to include(@test_order2.id)
        end
      end
    end
  end

 describe "GET #show" do
    before :each do
      @test_order = FactoryGirl.create(:order)
    end
    
    shared_examples_for "has appropriate permissions" do
      it_should_behave_like "valid id"
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      
      it "renders show template" do
        expect(response).to render_template :show
      end
    end
    
    context "logged in as user" do
      login_user
      
      it_should_behave_like "invalid id", :get, :show
      
      it_should_behave_like "does not have permission", :get, :show do 
        let (:sent_params) {{id: @test_order}}
      end
    end
    
    context "logged in as user with order" do
      login_user
      before :each do
        @test_order.user = controller.current_user
        @test_order.save
        get :show, params: {id: @test_order}
      end
      
      it_should_behave_like "has appropriate permissions" do 
        let(:test_order) {@test_order}
      end
    end
    
    context "logged in as admin" do
      login_admin
        
      context "as html request" do
        before :each do
          get :show, params: {id: @test_order}
        end
        
        it_should_behave_like "has appropriate permissions" do 
          let(:test_order) {@test_order}
        end
      end
      
      context "as json request" do
        render_views
        let(:json) { JSON.parse(response.body) }
        before do
          @product = FactoryGirl.create(:product)
          @promotion = FactoryGirl.create(:promotion)
          @test_order.products << @product
          @test_order.promotions << @promotion
          @test_order.save
          get :show, format: :json, params: { id: @test_order.id }
        end
        
        it_should_behave_like "has appropriate permissions" do 
          let(:test_order) {@test_order}
        end
        
        it "returns the order" do
          expect(json["id"]).to eql @test_order.id
        end
        
        it "displays products belonging to order" do
          expect(json["products"].count).to eql @test_order.products.count
          expect(json["products"].collect{|l| l["title"]}).to include @product.title
        end
        
        it "displays line_items belonging to order" do
          expect(json["line_items"].count).to eql @test_order.line_items.count
          expect(json["line_items"].collect{|l| l["id"]}).to include @test_order.line_items.first.id
        end
          
        it "displays promotions belonging to order" do
          expect(json["promotions"].count).to eql @test_order.promotions.count
          expect(json["promotions"].collect{|l| l["title"]}).to include @test_order.promotions.first.title
        end
      end
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

  describe "POST #create" do
    let (:valid_params) { { order: FactoryGirl.build(:order).attributes } }
    let (:invalid_params) { { order: FactoryGirl.build(:order, user_id: nil).attributes } }
    
    context "not logged in" do
      it "should redirect to login page if not logged in" do
        post :create, params: valid_params
        expect(response).to redirect_to new_user_session_path
      end
    end
    
    context "logged in" do
      login_user
      
      context "with valid parameters" do
        it "increases amount of orders by 1" do
          expect {
            post :create, params: valid_params
          }.to change(Order, :count).by(1)
        end

        it "redirects to the new order" do
          post :create, params: valid_params
          expect(response).to redirect_to Order.last
        end
      end

      context "with invalid parameters" do
        it "does not save new order" do
          expect{
            post :create, params: invalid_params
          }.to_not change(Order, :count)
        end
        
        it "re-renders the new method" do
          post :create, params: invalid_params
          expect(response).to render_template :new
        end
      end
    end
  end
  
  describe "PUT #update" do
    let (:valid_params) { FactoryGirl.build(:order, user: FactoryGirl.create(:user)).attributes }
    let (:invalid_params) { FactoryGirl.build(:order, user_id: nil).attributes }
    before(:each) do
      @test_order = FactoryGirl.create(:order)
    end
    
    context "as user" do
      login_user
      it "should raise an exception if not an admin" do
        expect do
          put :update, params: { id: @test_order.id }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end
    
    context "as admin" do
      login_admin
      
      context "invalid id" do 
        it "should return an ActiveRecord error if the order id does not exist" do
          expect do
            put :update, params: {id: -1, order: valid_params}
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
      
      context "valid_params" do
        before(:each) do
          @test_order = FactoryGirl.create(:order)
          put :update, params: {id: @test_order, order: valid_params}
          @test_order.reload
        end
        
        it "should find the correct order" do
          expect(assigns(:order)).to eql @test_order
        end

        it "should update object paramaters when logged in as admin" do
          expect(@test_order.user_id).to eql valid_params["user_id"]
          expect(@test_order.created_at).to_not eql @test_order.updated_at
        end
        
        it "should redirect to order page when successful" do
          expect(response).to redirect_to @test_order
        end
      end
      
      context "invalid params" do
        before(:each) do
          @test_order = FactoryGirl.create(:order)
          @original_user_id = @test_order.user_id
          put :update, params: { id: @test_order, order: invalid_params }
          @test_order.reload
        end
      
        it "should not update object paramaters when given invalid parameters" do
          expect(@test_order.user_id).to eql @original_user_id
          expect(@test_order.created_at).to eql @test_order.updated_at
        end
        
        it "should rerender edit page when update unsuccessful" do
          expect(response).to render_template :edit
        end
      end
    end
  end
  
  describe "DELETE #destroy" do
    before(:each) do
      @test_order = FactoryGirl.create(:order)
    end
    
    context "as user" do
      login_user

      it "should raise an exception if not an admin" do
        expect do
          delete :destroy, params: { id: @test_order }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end
    
    context "as admin" do
      login_admin
      
      it "should return an ActiveRecord error if the order id does not exist" do
        expect do
           delete :destroy, params: {id: -1}
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
      
      it "should find the correct order" do
        delete :destroy, params: { id: @test_order }
        expect(assigns(:order)).to eql @test_order
      end
      
      it "deletes the found order" do
        expect do
          delete :destroy, params: {id: @test_order }
        end.to change(Order, :count).by(-1)
      end
      
      it "redirects to the orders index" do
        delete :destroy, params: { id: @test_order }
        expect(response).to redirect_to orders_url
      end
    end
  end

end
