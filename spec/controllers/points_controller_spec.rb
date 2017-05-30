require 'rails_helper'

RSpec.describe CreditsController, type: :controller do

  let(:valid_attributes) { FactoryGirl.build(:credits).attributes }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:credits, value: nil) }

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
      @credit = FactoryGirl.create(:credits)
    end

    context "as admin" do
      login_admin
      it "assigns the requested credit as @credit" do
        get :edit, params: {id: @credit, credit: valid_attributes.slice('value')}
        expect(response).to have http_status(200)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Credit" do
        expect {
          post :create, params: {credit: valid_attributes}
        }.to change(Credit, :count).by(1)
      end

      it "assigns a newly created credit as @credit" do
        post :create, params: {credit: valid_attributes}
        expect(assigns(:credits)).to be_a(Credit)
        expect(assigns(:credits)).to be_persisted
      end

      it "redirects to the created credit" do
        post :create, params: {credit: valid_attributes}
        expect(response).to redirect_to(Credit.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved credit as @credit" do
        post :create, params: {credit: invalid_attributes}
        expect(assigns(:credits)).to be_a_new(Credit)
      end

      it "re-renders the 'new' template" do
        post :create, params: {credit: invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested credit" do
        credit = Credit.create! valid_attributes
        put :update, params: {id: credit.to_param, credit: new_attributes}
        credit.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested credit as @credit" do
        credit = Credit.create! valid_attributes
        put :update, params: {id: credit.to_param, credit: valid_attributes}
        expect(assigns(:credits)).to eq(credit)
      end

      it "redirects to the credit" do
        credit = Credit.create! valid_attributes
        put :update, params: {id: credit.to_param, credit: valid_attributes}
        expect(response).to redirect_to(credit)
      end
    end

    context "with invalid params" do
      it "assigns the credit as @credit" do
        credit = Credit.create! valid_attributes
        put :update, params: {id: credit.to_param, credit: invalid_attributes}
        expect(assigns(:credits)).to eq(credit)
      end

      it "re-renders the 'edit' template" do
        credit = Credit.create! valid_attributes
        put :update, params: {id: credit.to_param, credit: invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested credit" do
      credit = Credit.create! valid_attributes
      expect {
        delete :destroy, params: {id: credit.to_param}
      }.to change(Credit, :count).by(-1)
    end

    it "redirects to the credits list" do
      credit = Credit.create! valid_attributes
      delete :destroy, params: {id: credit.to_param}
      expect(response).to redirect_to(credits_url)
    end
  end

end
