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

    context "as admin" do
      login_admin
      it "returns http 200" do
        get :show
        expect(response).to have_http_status(200)
      end
    end

    context "as user" do
      login_user
      it "returns http 200" do
        get :show
        expect(response).to have_http_status(200)
      end
    end

    context "as non-user" do
      it "returns http 302" do
        get :show
        expect(response).to have_http_status(302)
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
      @point = FactoryGirl.create(:points)
    end

    context "as admin" do
      login_admin
      it "assigns the requested point as @point" do
        get :edit, params: {id: @point, point: valid_attributes.slice('value')}
        expect(response).to have http_status(200)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Point" do
        expect {
          post :create, params: {point: valid_attributes}
        }.to change(Point, :count).by(1)
      end

      it "assigns a newly created point as @point" do
        post :create, params: {point: valid_attributes}
        expect(assigns(:points)).to be_a(Point)
        expect(assigns(:points)).to be_persisted
      end

      it "redirects to the created point" do
        post :create, params: {point: valid_attributes}
        expect(response).to redirect_to(Point.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved point as @point" do
        post :create, params: {point: invalid_attributes}
        expect(assigns(:points)).to be_a_new(Point)
      end

      it "re-renders the 'new' template" do
        post :create, params: {point: invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested point" do
        point = Point.create! valid_attributes
        put :update, params: {id: point.to_param, point: new_attributes}
        point.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested point as @point" do
        point = Point.create! valid_attributes
        put :update, params: {id: point.to_param, point: valid_attributes}
        expect(assigns(:points)).to eq(point)
      end

      it "redirects to the point" do
        point = Point.create! valid_attributes
        put :update, params: {id: point.to_param, point: valid_attributes}
        expect(response).to redirect_to(point)
      end
    end

    context "with invalid params" do
      it "assigns the point as @point" do
        point = Point.create! valid_attributes
        put :update, params: {id: point.to_param, point: invalid_attributes}
        expect(assigns(:points)).to eq(point)
      end

      it "re-renders the 'edit' template" do
        point = Point.create! valid_attributes
        put :update, params: {id: point.to_param, point: invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested point" do
      point = Point.create! valid_attributes
      expect {
        delete :destroy, params: {id: point.to_param}
      }.to change(Point, :count).by(-1)
    end

    it "redirects to the points list" do
      point = Point.create! valid_attributes
      delete :destroy, params: {id: point.to_param}
      expect(response).to redirect_to(points_url)
    end
  end

end
