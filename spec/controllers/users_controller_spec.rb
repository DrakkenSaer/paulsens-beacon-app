require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    context "as admin" do
      login_admin
      it "returns http 200" do
        get :index
        expect(response).to have_http_status(200)
      end
    end

    context "as user" do
      login_user
      it "returns http 200" do
        get :index
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #show" do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    context "as admin" do
      login_admin
      it "returns http 200" do
        get :show, id: @user.id
        expect(response).to have_http_status(200)
      end
    end

    context "as user" do
      login_user
      it "returns http 200" do
        expect {
          get :show, id: @user.id
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end
