class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"

  def index
    @comments = Comment.includes(:user, :post).order(created_at: :desc)
  end

  def show
    @comment = Comment.find(params[:id])
  end
end