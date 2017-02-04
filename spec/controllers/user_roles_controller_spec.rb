require 'rails_helper'

RSpec.describe UserRolesController, type: :controller do

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

  describe "POST #create" do
    login_user

    before(:each) do
      @role = FactoryGirl.create(:role)
    end

    it "should add a role to the user"
    it "should not add the role if the user already has it"
    it "should not add an invalid role"
  end

end
