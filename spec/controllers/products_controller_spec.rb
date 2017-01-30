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
              post :create, { product: { featured: true, cost: "19.99", title: "test", description: "Test" } }
            end.to raise_error(Pundit::NotAuthorizedError)
          end
        end
        
        context "user have admin right" do
            login_admin
            
            context "with valid parameters" do
              it "increases amount of Product by 1" do
                expect {
                  post :create, { product: { featured: true, cost: "19.99", title: "test", description: "Test" } }
                }.to change(Product, :count).by(1)
              end
              
              it "redirects to the new Product after was made" do
                post :create, { product: { featured: true, cost: "19.99", title: "test", description: "Test" } }
                expect(response).to redirect_to Product.last
              end
            end
            
            context "with invalid parameters" do
              it "does not save new Product" do
                expect{
                  post :create, { product: { featured: true, cost: "19.99", description: "Test" } }
                }.to_not change(Product, :count)
              end
              
              it "re-renders the new method" do
                post :create, { product: { featured: true, cost: "19.99", description: "Test" } }
                expect(response).to render_template :new
              end
            end
        end
        
    end

end
