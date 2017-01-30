require 'rails_helper'
require 'date'

RSpec.describe HistoricalEventsController, type: :controller do

  # describe "GET #index" do
  #   it "returns http success" do
  #     get :index
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  
  

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "POST create" do
    
    context "as user" do
      login_user
      it "should raise an exception if not an admin" do
        expect do
          post :create, { historical_event: { title: "test", description: "Test", date: "2001-6-4" } }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end
    
    context "user have admin right" do
        login_admin
        
        context "with valid parameters" do
          it "increases amount of HistoricalEvent by 1" do
            expect {
              post :create, { historical_event: { title: "test", description: "Test", date: "2001-6-4" } }
            }.to change(HistoricalEvent, :count).by(1)
          end
          
          it "redirects to the new historical_event after was made" do
            post :create, { historical_event: { title: "test", description: "Test", date: "2001-6-4" } }
            expect(response).to redirect_to HistoricalEvent.last
          end
        end
        
        context "with invalid parameters" do
          it "does not save new beacon" do
            expect{
              post :create, { historical_event: { title: "test", description: "Test" } }
            }.to_not change(HistoricalEvent, :count)
          end
          
          it "re-renders the new method" do
            post :create, { historical_event: { title: "test", description: "Test" } }
            expect(response).to render_template :new
          end
      end
    end
  end
  
  describe 'DELETE destroy' do
    context "have admin right" do
      login_admin
      it "deletes the Historical event" do
        historical_event = FactoryGirl.create(:historical_event)

        expect{
          delete :destroy, { id: historical_event.id }    
        }.to change(HistoricalEvent, :count).by(-1)
      end
    end

  end
  
end
