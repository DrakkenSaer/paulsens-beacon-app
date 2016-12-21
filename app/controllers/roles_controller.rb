class RolesController < ApplicationController
  before_action :authenticate_user!

  def index
    @roles = policy_scope(Role)
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
