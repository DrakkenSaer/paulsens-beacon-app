require 'rails_helper'

RSpec.describe BeaconsController, type: :controller do

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
  
  describe "POST #create" do
    let (:valid_params){{"beacon" => {"title" => 'test', "description" => 'test'}}}
    let (:invalid_params){{"beacon" => {"cake" => 'test'}}}
    login_admin
    
    context "with valid parameters" do
      it "increases amount of beacons by 1" do
        expect {
          post :create, valid_params
        }.to change(Beacon, :count).by(1)
      end
      
      it "redirects to the new beacon" do
        post :create, valid_params
        expect(response).to redirect_to Beacon.last
      end
    end
    
    context "with invalid parameters" do
      it "does not save new beacon" do
        expect{
          post :create, invalid_params
        }.to_not change(Beacon,:count)
      end
      
      it "re-renders the new method" do
        post :create, invalid_params
        expect(response).to have_rendered("new")
      end
    end
  end

end
