require 'rails_helper'

RSpec.describe PointsController, type: :controller do

  let(:valid_attributes) { FactoryGirl.build(:points).attributes }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:points, value: nil) }

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

    context "as non-user" do
      it "returns http 302" do
        get :index
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "GET #show" do
    before :each do
      user = FactoryGirl.create(:user)
      @point = user.points(attributes_for(:points))
    end

    context "as admin" do
      login_admin
      it "returns http 200" do
        get :show, id: @point.id
        expect(response).to have_http_status(200)
      end
    end

    context "as user" do
      login_user
      it "returns http 200" do
        get :show, id: @point.id
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #new" do
    context "as admin" do
      login_admin
      it "returns http 200" do
        get :new
        expect(response).to have_http_status(200)
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
    end
  end

  describe "GET #edit" do
    before :each do
      user = FactoryGirl.create(:user)
      @resource = user.points(attributes_for(:points))
    end

    context "as admin" do
      login_admin
      it "returns http 200" do
        get :show, id: @resource.id, point: valid_attributes
        expect(response).to have_http_status(200)
      end
    end

    context "as user" do
      login_user
      it "returns http 200" do
        get :show, id: @resource.id, point: valid_attributes
        expect(response).to have_http_status(200)
      end
    end

    context "as non-user" do
      it "returns http 302" do
        get :show, id: @resource.id, point: valid_attributes
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "POST #create" do

    context "with valid attributes" do
      context "as admin" do
        login_admin
        it "change the count by 1" do
          expect {
            @resource = FactoryGirl.create(:user)
            post :create, id: @resource.id, point: valid_attributes
          }.to change(Point, :count).by(2)
        end
      end

      context "as user" do
        login_user
        it "change the count by 2" do
          expect {
            @resource = FactoryGirl.create(:user)
            post :create, id: @resource.id, point: valid_attributes
          }.to raise_error(Pundit::NotAuthorizedError)
        end
      end

      context "as non-user" do
        it "returns http 302" do
          @resource = FactoryGirl.create(:user)
          post :create, id: @resource.id, point: valid_attributes
          expect(response).to have_http_status(302)
        end
      end
    end

    context "with invalid attributes" do
      context "as admin" do
        login_admin
        it "change the count by 2" do
          @resource = FactoryGirl.create(:user)
          post :create, id: @resource.id, point: invalid_attributes
          expect(response).to render_template(:new)
        end
      end

      context "as user" do
        login_user
        it "change the count by 2" do
          expect {
            @resource = FactoryGirl.create(:user)
            post :create, id: @resource.id, point: invalid_attributes
          }.to raise_error(Pundit::NotAuthorizedError)
        end
      end

      context "as non-user" do
        it "returns http 302" do
          @resource = FactoryGirl.create(:user)
          post :create, id: @resource.id, point: invalid_attributes
          expect(response).to have_http_status(302)
        end
      end
    end
  end

  describe "PUT #update" do
    before :each do
      user = FactoryGirl.create(:user)
      @resource = user.points(attributes_for(:points))
    end

    context "with valid attributes" do
      context "as admin" do
        login_admin
        it "returns a 302" do
          put :update, id: @resource.id, point: valid_attributes
          expect(response).to have_http_status(302)
        end
      end

      context "as user" do
        login_user
        it "should raise_error if not admin" do
          expect {
            put :update, id: @resource.id, point: valid_attributes
          }.to raise_error(Pundit::NotAuthorizedError)
        end
      end

      context "as non-user" do
        it "returns http 302" do
          put :update, id: @resource.id, point: valid_attributes
          expect(response).to have_http_status(302)
        end
      end
    end

    context "with invalid attributes" do
      context "as admin" do
        login_admin
        it "should render template edit if params are invalid" do
          put :update, id: @resource.id, point: invalid_attributes
          expect(response).to have_http_status(302)
        end
      end

      context "as user" do
        login_user
        it "should raise_error if not admin" do
          expect {
            put :update, id: @resource.id, point: invalid_attributes
          }.to raise_error(Pundit::NotAuthorizedError)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      user = FactoryGirl.create(:user)
      @resource = user.points(attributes_for(:points))
    end

    context "as admin" do
      login_admin
      it "destroys the requested point" do
        expect {
          delete :destroy, id: @resource.id
        }.to change(Point, :count).by(-1)
      end
    end

    context "as user" do
      login_user
      it "destroys the requested point" do
        expect {
          delete :destroy, id: @resource.id
        }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "as non-user" do
      it "destroys the requested point" do
        delete :destroy, id: @resource.id
        expect(response).to have_http_status(302)
      end
    end
  end
end
