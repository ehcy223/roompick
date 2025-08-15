class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!  # 管理者のみアクセス可能
  layout 'admin'  # 専用レイアウト
  
  def top
    @recent_posts    = Post.includes(:user).order(created_at: :desc).limit(5)
    @recent_comments = Comment.includes(:user, :post).order(created_at: :desc).limit(5)
    @new_users       = User.order(created_at: :desc).limit(5)
  end
end
