class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @categories = Category.order(:name)
  end

  def show
    @category = Category.find(params[:id])
    @posts = Post.where(category_id: @category.id).order(created_at: :desc)
  end
end
