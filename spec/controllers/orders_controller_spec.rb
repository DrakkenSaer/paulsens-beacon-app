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

#   describe "GET #create" do
#     it "returns http success" do
#       get :create
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "GET #edit" do
#     it "returns http success" do
#       get :edit
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "GET #update" do
#     it "returns http success" do
#       get :update
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "GET #destroy" do
#     it "returns http success" do
#       get :destroy
#       expect(response).to have_http_status(:success)
#     end
#   end

  describe "POST #create" do
    let (:valid_params) { { order: { user_id: 1 } } }
    let (:invalid_params) { { order: FactoryGirl.build(:order, user_id: nil) } }
    login_user

    context "with valid parameters" do
      it "increases amount of orders by 1" do
        expect {
          post :create, params: valid_params
        }.to change(Order, :count).by(1)
      end
      
      # it "redirects to the new order" do
      #   post :create, params: valid_params
      #   expect(response).to redirect_to Order.last
      # end
    end
  end

end
