class PromotionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @promotions = policy_scope(Promotion)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
