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
    context "have admin right" do
      login_admin
      it "creates a new Hitorical event" do
        expect{
          post :create, params: { historical_event: { title: "test", description: "Test", date: "2001-6-4" } }
        }.to change(HistoricalEvent, :count).by(1)
      end
    end
  
    # context "have just user" do
    #   login_user
    #   it "does not save the new historical event" do
    #     post :create, {"historical_event" => {"title" => "test", "description" => "Test", "date" => "2001-4-4"}}
    #     expect(response).to have_http_status(:redirect)
    #   end
    # end 
  end
  
  describe 'DELETE destroy' do
    context "have admin right" do
      login_admin
      it "deletes the Historical event" do
        historical_event = FactoryGirl.create(:historical_event)

        expect{
          delete :destroy, params: { id: historical_event.id }    
        }.to change(HistoricalEvent, :count).by(-1)
      end
    end

    # it "redirects to contacts#index" do
    #   delete :destroy, id: @contact
    #   response.should redirect_to historical_event_url
    # end
  end
  
end
