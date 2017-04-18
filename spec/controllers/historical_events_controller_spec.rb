require 'rails_helper'

RSpec.describe HistoricalEventsController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }

  describe "GET #index" do

    before(:each) do
      @historical_event = FactoryGirl.create(:historical_event)
      get :index, format: :json
    end

    it "returns http success for json" do
      expect(response).to have_http_status(:success)
    end

    it "get the data from json success" do
      expect(json["historical_events"].collect{|l| l["title"]}).to include(@historical_event.title)
    end
  end

  describe "GET #show" do
    context 'get HistoricalEvent show by id' do
      before(:each) do
        @historical_event = FactoryGirl.create(:historical_event)
        get :show, format: :json, params: { id: @historical_event.id }
      end
      it "returns http success for json" do
        expect(response).to have_http_status(:success)
      end

      it "returns json success" do
        expect(json["title"]).to include(@historical_event.title)
      end
    end

  end

  describe "GET #new" do
    context "as admin" do
      login_admin
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context "as user" do
      login_user
      it "should raise_error if not admin" do
        expect {
          get :new
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "as non-user" do
      it "returns 302" do
        get :new
        expect(response).to have_http_status(302)
      end

      it "redirect to login page" do
        get :new
        expect(response.body).to eq("<html><body>You are being <a href=\"http://test.host/login\">redirected</a>.</body></html>")
      end
    end
  end

  describe "GET #edit" do
    before :each do
      @historical_event = FactoryGirl.create(:historical_event)
    end

    context "as admin" do
      login_admin
      it "returns http success" do
        get :edit, id: @historical_event.id
        expect(response).to have_http_status(:success)
      end
    end

    context "as user" do
      login_user
      it "should raise_error if not admin" do
        expect {
          get :edit, id: @historical_event.id
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "as non-user" do
      it "returns http 302" do
        get :edit, id: @historical_event.id
        expect(response).to have_http_status(302)
      end

      it "redirect to login page" do
        get :edit, id: @historical_event.id
        expect(response.body).to eq("<html><body>You are being <a href=\"http://test.host/login\">redirected</a>.</body></html>")
      end
    end
  end

  describe "POST create" do
    let (:valid_params) { { title: "test", description: "Test", date: "2001-6-4" } }
    let (:invalid_params) { { title: nil } }

    context "as user" do
      login_user

      it "should raise an exception if not an admin" do
        expect do
          post :create, params: { historical_event: valid_params }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "user have admin right" do
      login_admin

      context "with valid parameters" do
        it "increases amount of HistoricalEvent by 1" do
          expect {
            post :create, params: { historical_event: valid_params }
          }.to change(HistoricalEvent, :count).by(1)
        end

        it "redirects to the new historical_event after was made" do
          post :create, params: { historical_event: valid_params }
          expect(response).to redirect_to HistoricalEvent.last
        end
      end

      context "with invalid parameters" do
        it "does not save new HistoricalEvent" do
          expect{
            post :create, params: { historical_event: invalid_params }
          }.to_not change(HistoricalEvent, :count)
        end

        it "re-renders the new method" do
          post :create, params: { historical_event: invalid_params }
          expect(response).to render_template :new
        end
      end
    end

    context "as non-user" do
      it "returns http 302" do
        post :create, params: { historical_event: valid_params }
        expect(response).to have_http_status(302)
      end

      it "redirect to login page" do
        post :create, params: { historical_event: valid_params }
        expect(response.body).to eq("<html><body>You are being <a href=\"http://test.host/login\">redirected</a>.</body></html>")
      end
    end
  end

  describe 'DELETE destroy' do
    context "as user" do
      login_user

      it "should raise an exception if not an admin" do
        historical_event = FactoryGirl.create(:historical_event)
        expect do
          delete :destroy, params: { id: historical_event.id }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "user have admin right" do
      login_admin

      before(:each) do
        @historical_event = FactoryGirl.create(:historical_event)
      end

      it "should return an ActiveRecord error if the beacon id does not exist" do
        expect do
          delete :destroy, params: {id: -1}
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      context "with valid id" do
        it "decreases amount of HistoricalEvent by 1" do
          expect{
            delete :destroy, params: { id: @historical_event.id }
          }.to change(HistoricalEvent, :count).by(-1)
        end

        it "redirects to historical_events_url after destroy historical_event" do
          post :destroy, params: { id: @historical_event.id }
          expect(response).to redirect_to(historical_events_url)
        end
      end
    end
  end

  describe "PUT #update" do
    context "as user" do
      login_user

      it "should raise an exception if not an admin" do
        historical_event = FactoryGirl.create(:historical_event)
        expect do
          put :update, params: { id: historical_event }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "as admin" do
      let (:valid_params) { { title: "bob", description: "bob", date: "2001-6-30" } }
      let (:invalid_params) { { title: nil } }

      login_admin
      context "valid_params" do
        before(:each) do
          @historical_event = FactoryGirl.create(:historical_event)
          put :update, params: { id: @historical_event.id, historical_event: valid_params }
          @historical_event.reload
        end

        it "should update object paramaters when logged in as admin" do
          expect(@historical_event.title).to eql valid_params[:title]
          expect(@historical_event.description).to eql valid_params[:description]
          expect(@historical_event.date).to eq(valid_params[:date].to_date)
        end

        it "should redirect to beacon page when successful" do
          expect(response).to redirect_to @historical_event
        end
      end

      context "invalid params" do
        before(:each) do
          @historical_event = FactoryGirl.create(:historical_event)
          put :update, params: { id: @historical_event.id, historical_event: invalid_params }
          @historical_event.reload
        end

        it "should not update object paramaters when given invalid parameters" do
          expect(@historical_event.title).to eql "test"
          expect(@historical_event.description).to eql "test"
          expect(@historical_event.date).to eql "2001-1-1".to_date
        end

        it "should rerender edit page when update unsuccessful" do
          put :update, params: { id: @historical_event.id, historical_event: invalid_params }
          expect(response).to render_template :edit
        end
      end
    end
  end
end
