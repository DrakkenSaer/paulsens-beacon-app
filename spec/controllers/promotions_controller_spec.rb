require 'rails_helper'

RSpec.describe PromotionsController, type: :controller do

#   describe "GET #index" do
#     it "returns http success" do
#       get :index
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "GET #show" do
#     it "returns http success" do
#       get :show
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "GET #new" do
#     it "returns http success" do
#       get :new
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "GET #create" do
#     it "returns http success" do
#       get :create
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "GET #edit" do
#     it "returns http success" do
#       get :edit
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "GET #update" do
#     it "returns http success" do
#       get :update
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "GET #destroy" do
#     it "returns http success" do
#       get :destroy
#       expect(response).to have_http_status(:success)
#     end
#   end
  
  describe "POST #create" do
    let (:valid_params) { { promotion: FactoryGirl.attributes_for(:promotion) } }
    let (:invalid_params) { { promotion: FactoryGirl.attributes_for(:promotion, title: nil) } }
    login_user 
    
    context "with valid parameters" do
      it "increases amount of promotions by 1" do
        expect {
          post :create, params: valid_params
        }.to change(Promotion, :count).by(1)
      end
      
      it "redirects to new promotion" do
        post :create, params: valid_params
        expect(response).to redirect_to Promotion.last
      end
    end
    
    context "with invalid parameters" do
      it "does not save new promotion" do
        expect{
          post :create, params: invalid_params
        }.to_not change(Promotion, :count)
      end
      
      it "re-renders the new method" do
        post :create, params: invalid_params
        expect(response).to render_template :new
      end
    end
  end
  
  describe "PUT #update" do
    let (:valid_params) { FactoryGirl.attributes_for(:promotion, title: "new title", description: "new description") }
    let (:invalid_params) { FactoryGirl.attributes_for(:promotion, title: nil) }
    login_user
    
    context "invalid id" do
      it "should return an ActiveRecord error if the promotion id does not exist" do
        expect do
           put :update, params: {id: 999, promotion: valid_params}
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
    
    context "valid parameters" do
      before(:each) do
        @test_promotion = FactoryGirl.create(:promotion)
        put :update, params: {id: @test_promotion, promotion: valid_params}
        @test_promotion.reload
      end
      
      it "should find the correct promotion" do
        expect(assigns(:promotion)).to eql @test_promotion
      end
      
      it "should update object paramaters" do
        expect(@test_promotion.title).to eql valid_params[:title]
        expect(@test_promotion.description).to eql valid_params[:description]
        expect(@test_promotion.created_at).to_not eql @test_promotion.updated_at
      end
      
      it "should redirect to promotion page when successful" do
        expect(response).to redirect_to @test_promotion
      end
    end
    
    context "with invalid parameters" do
      before(:each) do
        @test_promotion = FactoryGirl.create(:promotion)
        put :update, params: {id: @test_promotion, promotion: invalid_params}
        @test_promotion.reload
      end
      
      it "should not update object parameters" do
        expect(@test_promotion.title).to eql FactoryGirl.attributes_for(:promotion)[:title]
        expect(@test_promotion.created_at).to eql @test_promotion.updated_at
      end
      
      it "should rerender edit page when update unsuccessful" do
        expect(response).to render_template :edit
      end
    end
  end
  
  describe "DELETE #destroy" do
    before(:each) do
      @test_promotion = FactoryGirl.create(:promotion)
    end
    login_user
    
    it "should return an ActiveRecord error if the promotion id does not exist" do
      expect do
         delete :destroy, params: {id: 999}
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
    
    it "should find the correct promotion" do
      delete :destroy, params: {id: @test_promotion}
      expect(assigns(:promotion)).to eql @test_promotion
    end
    
    it "deletes the promotion from the database" do
      expect do
         delete :destroy, params: { id: @test_promotion }
      end.to change(Promotion, :count).by(-1)
    end
    
    it "redirects to the promotion index" do
      delete :destroy, params: { id: @test_promotion }
      expect(response).to redirect_to promotions_url
    end
  end
    
end
