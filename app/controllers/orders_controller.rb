class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = policy_scope(Order)
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
