require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do

  let (:valid_params) { FactoryGirl.attributes_for(:notification) }
  let (:invalid_params) { { title: nil } }

  describe "GET #index" do
    context "as admin" do
      login_admin
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context "as user" do
      login_user
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context "as non-user" do
      it "returns http 302" do
        get :index
        expect(response).to have_http_status(302)
      end

      it "page should have" do
        get :index
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/login">redirected</a>.</body></html>')
      end
    end
  end

  describe "GET #show" do
    before :each do
      @beacon = FactoryGirl.create(:beacon)
      @notification = @beacon.notifications.create(attributes_for(:notification))
    end

    context "as admin" do
      login_admin
      it "returns http success" do
        get :show, params: { id: @notification.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "as user" do
      login_user
      it "returns http success" do
        get :show, params: { id: @notification.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "as non-user" do
      it "returns http 302" do
        get :show, params: { id: @notification.id }
        expect(response).to have_http_status(302)
      end

      it "page should have" do
        get :show, params: { id: @notification.id }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/login">redirected</a>.</body></html>')
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
      it "returns http 302" do
        get :new
        expect(response).to have_http_status(302)
      end

      it "page should have" do
        get :new
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/login">redirected</a>.</body></html>')
      end
    end
  end

  describe "GET #create" do
    before :each do
      FactoryGirl.create(:beacon)
      @attr = FactoryGirl.attributes_for(:notification)
    end

    context "as admin" do
      login_admin
      it "returns http 302 after done creating" do
        get :create, params: { notification: @attr }
        expect(response).to have_http_status(302)
      end

      it "should increment the count by 1" do
        expect{
          get :create, params: { notification: @attr }
        }.to change{Notification.count}.by 1
      end
    end

    context "as user" do
      login_user
      it "should raise_error if not admin" do
        expect {
          get :create, params: { notification: @attr }
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "as non-user" do
      it "returns http 302 to login page" do
        get :create, params: { notification: @attr }
        expect(response).to have_http_status(302)
      end

      it "page should have" do
        get :create, params: { notification: @attr }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/login">redirected</a>.</body></html>')
      end
    end
  end

  describe "GET #edit" do
    before :each do
      beacon = FactoryGirl.create(:beacon)
      @notification = beacon.notifications.create(attributes_for(:notification))
    end

    context "as admin" do
      login_admin
      it "returns http success" do
        get :edit, params: { id: @notification }
        expect(response).to have_http_status(:success)
      end
    end

    context "as user" do
      login_user
      it "returns http success" do
        expect {
          get :edit, params: { id: @notification }
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "as non-user" do
      it "returns http 302 to login page" do
        get :edit, params: { id: @notification.id }
        expect(response).to have_http_status(302)
      end

      it "page should have" do
        get :edit, params: { id: @notification.id }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/login">redirected</a>.</body></html>')
      end
    end
  end

  describe "GET #update" do
    before :each do
      beacon = FactoryGirl.create(:beacon)
      @notification = beacon.notifications.create(attributes_for(:notification))
    end

    context "as admin" do
      login_admin
      it "returns http 302 when updated" do
        put :update, params: {id: @notification.id, notification: valid_params}
        expect(response).to have_http_status(302)
      end

      it "with invalid params should render template edit" do
        put :update, params: {id: @notification.id, notification: invalid_params}
        expect(response).to render_template("edit")
      end
    end

    context "as user" do
      login_user
      it "should raise_error if not admin" do
        expect {
        put :update, params: {id: @notification.id, notification: valid_params}
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "as non-user" do
      it "returns http 302 if user not logged in" do
        put :update, params: {id: @notification.id, notification: valid_params}
        expect(response).to have_http_status(302)
      end

      it "page should have" do
        put :update, params: {id: @notification.id, notification: valid_params}
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/login">redirected</a>.</body></html>')
      end
    end
  end

  describe "GET #destroy" do
    before :each do
      beacon = FactoryGirl.create(:beacon)
      @notification = beacon.notifications.create(attributes_for(:notification))
    end

    context "as admin" do
      login_admin
      it "returns http 302 when deleted" do
        get :destroy, params: { id: @notification }
        expect(response).to have_http_status(302)
      end

      it "returns http 302 when deleted" do
        expect{
          get :destroy, params: { id: @notification }
        }.to change{Notification.count}.by(-1)
      end
    end

    context "as user" do
      login_user
      it "should raise_error if not admin" do
        expect {
          get :destroy, params: { id: @notification }
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "as non-user" do
      it "returns http 302 when deleted" do
        get :destroy, params: { id: @notification }
        expect(response).to have_http_status(302)
      end

      it "page should have" do
        get :destroy, params: { id: @notification }
        expect(response.body).to eq('<html><body>You are being <a href="http://test.host/login">redirected</a>.</body></html>')
      end
    end
  end
end
