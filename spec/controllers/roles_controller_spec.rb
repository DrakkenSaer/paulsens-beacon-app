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
  
  describe 'DELETE destroy' do
    
    context "as user" do
      login_user
      it "should raise an exception if not an admin" do
        role = FactoryGirl.create(:role)
        expect do
          delete :destroy, {id: role.id }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end
    
    context "user have admin right" do
        login_admin
        
        it "should return an ActiveRecord error if the role id does not exist" do
          expect do
            delete :destroy, params: {id: 9001}
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
        
        context "with valid id" do
          it "decreases amount of Role by 1" do
            role = FactoryGirl.create(:role)
            expect{
              delete :destroy, { id: role.id }    
            }.to change(Role, :count).by(-1)
          end
          
          it "redirects to roles_url after destroy role" do
            role = FactoryGirl.create(:role)
            post :destroy, { id: role.id }
            expect(response).to redirect_to(roles_url)
          end
        end
    end
  end
  
  describe "PUT #update" do
  
    context "as user" do
      login_user
      it "should raise an exception if not an admin" do
        role = FactoryGirl.create(:role)
        expect do
          put :update, params: { id: role }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end
    
   context "as admin" do
      let (:valid_params) { { name: "bob" } }
      let (:invalid_params) { { name: nil, resource_type: nil } }
     
      login_admin
      context "valid_params" do
        before(:each) do
          @role = FactoryGirl.create(:role)
          put :update, id: @role.id, role: valid_params
          @role.reload
        end

        it "should update object paramaters when logged in as admin" do
          expect(@role.name).to eql valid_params[:name]
        end
        
        it "should redirect to beacon page when successful" do
          expect(response).to redirect_to @role
        end
      end
      
      context "invalid params" do
         before(:each) do
          @role = FactoryGirl.create(:role)
          put :update, id: @role.id, role: invalid_params
          @role.reload
        end
      
        it "should not update object paramaters when given invalid parameters" do
          expect(@role.name).to eql "test"
        end
        
        it "should rerender edit page when update unsuccessful" do
          put :update, id: @role, role: invalid_params
          expect(response).to render_template :edit
        end
      end
    end
  end

end
