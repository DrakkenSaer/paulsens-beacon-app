require 'rails_helper'

RSpec.describe BeaconsController, type: :controller do
  
  shared_examples_for "does not have permission" do | http_verb, controller_method | 
    it "should raise a Pundit exception" do
      expect do
        send(http_verb, controller_method, params: sent_params)
      end.to raise_error(Pundit::NotAuthorizedError)
    end
  end
  
  shared_examples_for "invalid id" do | http_verb, controller_method | 
    it "should raise an ActiveRecord exception" do
      expect do
        send(http_verb, controller_method, params: {id: -1})
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
  
  shared_examples_for "valid id" do
    it "should find the correct beacon" do
      expect(assigns(:beacon)).to eql test_beacon
    end
  end

  describe "GET #index" do
    login_user
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    before :each do
      @test_beacon = FactoryGirl.create(:beacon)
    end
    
    context "logged in as user" do
      login_user
  
      it_should_behave_like "does not have permission", :get, :show do 
        let (:sent_params) {{id: @test_beacon}}
      end
      
      it_should_behave_like "invalid id", :get, :show
    end
    
    context "logged in as admin" do
      login_admin
      
      shared_examples_for "has appropriate permissions" do
        it_should_behave_like "valid id"
        
        it "returns http success" do
          expect(response).to have_http_status(:success)
        end
        
        it "renders show template" do
          expect(response).to render_template :show
        end
      end
        
      context "as html request" do
        before :each do
          get :show, params: {id: @test_beacon}
        end
        
        it_should_behave_like "has appropriate permissions" do 
          let(:test_beacon) {@test_beacon}
        end
      end
      
      context "as json request" do
        render_views
        let(:json) { JSON.parse(response.body) }
        before do
          @notification = FactoryGirl.create(:notification)
          @test_beacon.notifications << @notification
          get :show, format: :json, params: { id: @test_beacon.id }
        end
        
        it_should_behave_like "has appropriate permissions" do 
          let(:test_beacon) {@test_beacon}
        end
        
        it "returns the beacon" do
          expect(json["title"]).to eql @test_beacon.title
        end
        
        it "displays notifications belonging to beacon" do
          expect(json["notifications"].count).to eql @test_beacon.notifications.count
          expect(json["notifications"][0]["title"]).to eql @notification.title
        end
      end
    end
  end

  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "POST #create" do
    let (:valid_params) { { beacon: FactoryGirl.attributes_for(:beacon) } }
    let (:invalid_params) { { beacon: FactoryGirl.attributes_for(:beacon, title: nil) } }

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
    let (:valid_params) { FactoryGirl.attributes_for(:beacon, title: "new title", description: "new description") }
    let (:invalid_params) { FactoryGirl.attributes_for(:beacon, title: nil) }

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
      
      context "invalid id" do 
        it "should return an ActiveRecord error if the beacon id does not exist" do
          expect do
             put :update, params: {id: -1, beacon: valid_params}
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
      
      context "valid_params" do
        before(:each) do
          @test_beacon = FactoryGirl.create(:beacon)
          put :update, params: {id: @test_beacon, beacon: valid_params}
          @test_beacon.reload
        end
        
        it "should find the correct beacon" do
          expect(assigns(:beacon)).to eql @test_beacon
        end

        it "should update object paramaters" do
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
      
        it "should not update object paramaters" do
          expect(@test_beacon.title).to eql "test"
          expect(@test_beacon.description).to eql "test description"
        end
        
        it "should rerender edit page when update unsuccessful" do
          expect(response).to render_template :edit
        end
      end
    end
  end
  
  describe "DELETE #destroy" do
    before(:each) do
      @test_beacon = FactoryGirl.create(:beacon)
    end
    
    context "as user" do
      login_user
      
      it "should raise an exception if not an admin" do
        expect do
          delete :destroy, params: { id: @test_beacon.id }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end
    
    context "as admin" do
      login_admin
      
      it "should return an ActiveRecord error if the beacon id does not exist" do
        expect do
           delete :destroy, params: {id: -1}
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
      
      it "should find the correct beacon" do
        delete :destroy, params: { id: @test_beacon.id }
        expect(assigns(:beacon)).to eql @test_beacon
      end
      
      it "deletes the beacon from the database" do
        expect do
           delete :destroy, params: { id: @test_beacon.id }
        end.to change(Beacon, :count).by(-1)
      end
      
      it "redirects to the beacons index" do
        delete :destroy, params: {id: @test_beacon.id}
        expect(response).to redirect_to beacons_url
      end
    end
  end

end
