class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"

  def index
    @posts = Post.order(created_at: :desc)
    @posts = @posts.where("title LIKE ?", "%#{params[:q]}%") if params[:q].present?
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path, notice: "投稿を削除しました"
  end
end