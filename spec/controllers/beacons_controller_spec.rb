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
    let (:valid_params) { { beacon: { title: 'test', description: 'test' } } }
    let (:invalid_params) { { beacon: { title: nil } } }

    context "as user" do
      login_user
      it "should raise an exception if not an admin" do
        expect do
          post :create, params: valid_params
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end
    
    context "as admin" do
      login_admin

      context "with valid parameters" do
        it "increases amount of beacons by 1" do
          expect {
            post :create, params: valid_params
          }.to change(Beacon, :count).by(1)
        end
        
        it "redirects to the new beacon" do
          post :create, params: valid_params
          expect(response).to redirect_to Beacon.last
        end
      end
      
      context "with invalid parameters" do
        it "does not save new beacon" do
          expect{
            post :create, params: invalid_params
          }.to_not change(Beacon, :count)
        end
        
        it "re-renders the new method" do
          post :create, params: invalid_params
          expect(response).to render_template :new
        end
      end
    end
  end
  
  describe "PUT #update" do
    let (:valid_params) { { title: 'new title', description: 'new description' } }
    let (:invalid_params) { { title: nil } }

    context "as user" do
      login_user
      it "should raise an exception if not an admin" do
        test_beacon = FactoryGirl.create(:beacon)
        expect do
          put :update, params: { id: test_beacon.id }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end
    
    context "as admin" do
      login_admin
      context "valid_params" do
        before(:each) do
          @test_beacon = FactoryGirl.create(:beacon)
          put :update, params: {id: @test_beacon.id, beacon: valid_params}
          @test_beacon.reload
        end

        it "should update object paramaters when logged in as admin" do
          expect(@test_beacon.title).to eql valid_params[:title]
          expect(@test_beacon.description).to eql valid_params[:description]
        end
        
        it "should redirect to beacon page when successful" do
          expect(response).to redirect_to @test_beacon
        end
      end
      
      context "invalid params" do
        before(:each) do
          @test_beacon = FactoryGirl.create(:beacon)
          put :update, params: { id: @test_beacon.id, beacon: invalid_params }
          @test_beacon.reload
        end
      
        it "should not update object paramaters when given invalid parameters" do
          expect(@test_beacon.title).to eql "test"
          expect(@test_beacon.description).to eql "test description"
        end
        
        it "should rerender edit page when update unsuccessful" do
          expect(response).to render_template :edit
        end
      end
    end
  end
  
  # describe "DELETE #destroy" do
  #   before(:each) do
  #     @test_beacon = FactoryGirl.create(:beacon)
  #   end
    
  #   context "as user" do
  #     login_user
      
  #     it "should raise an exception if not an admin" do
  #       expect do
  #       put :update, params: { id: @test_beacon.id }
  #       end.to raise_error(Pundit::NotAuthorizedError)
  #     end
  #   end
  # end

end
