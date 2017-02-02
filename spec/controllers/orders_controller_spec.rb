require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

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
          p valid_params
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
  
  describe "Delete #destroy" do
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
