require 'rails_helper'

RSpec.describe RolesController, type: :controller do

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

describe "POST create" do
    
    context "as user" do
      login_user
      it "should raise an exception if not an admin" do
        expect do
          post :create, { role: { name: "test" } }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end
    
    context "user have admin right" do
        login_admin
        
        context "with valid parameters" do
          it "increases amount of Role by 1" do
            expect {
              post :create, { role: { name: "test" } }
            }.to change(Role, :count).by(1)
          end
          
          it "redirects to the new role after was made" do
            post :create, { role: { name: "test"} }
            expect(response).to redirect_to Role.last
          end
        end
        
        context "with invalid parameters" do
          it "does not save new Role" do
            expect{
              post :create, { role: { resource_type: "Test" } }
            }.to_not change(Role, :count)
          end
          
          it "re-renders the new method" do
            post :create, { role: { resource_type: "Test" } }
            expect(response).to render_template :new
          end
      end
    end
  end

end
