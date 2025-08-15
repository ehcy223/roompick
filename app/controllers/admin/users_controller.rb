class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @users = User.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end
end
