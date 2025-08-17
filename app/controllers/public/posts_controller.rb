module Public
  class PostsController < ApplicationController
    # 要件：未ログインは詳細も見せない
    before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update, :destroy]
    before_action :set_post,          only:  [:show, :edit, :update, :destroy]
    # 本人のみ編集可：他人が来たら一覧へ
    before_action :ensure_owner!,     only:  [:edit, :update, :destroy]

    # 投稿一覧（ここは誰でも閲覧可）
    def index
      @posts = Post.order(created_at: :desc).page(params[:page]).per(12)
    end

    # ユーザー別投稿一覧 /users/:user_id/posts
    def user_posts
      @user  = User.find(params[:user_id])
      @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(12)
      render :index
    end

    # 詳細
    def show
      # @post は set_post 済み
    end

    # 新規
    def new
      @post = Post.new
    end

    # 作成
    def create
      @post = current_user.posts.new(post_params)
      if @post.save
        redirect_to @post, notice: '投稿が作成されました'
      else
        render :new
      end
    end

    # 編集
    def edit
      # @post は set_post 済み / ensure_owner! 済み
    end

    # 更新
    def update
      if @post.update(post_params)
        redirect_to @post, notice: '投稿が更新されました'
      else
        render :edit
      end
    end

    # 削除（削除後はマイページへ）
    def destroy
      @post.destroy
      redirect_to mypage_path, notice: '投稿が削除されました'
    end

    # 検索
    def search
      keyword = params[:keyword]
      @posts = if keyword.present?
                 Post.where("title LIKE ?", "%#{keyword}%").order(created_at: :desc)
               else
                 Post.order(created_at: :desc)
               end
      render :index
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    # 本人以外は一覧へ
    def ensure_owner!
      redirect_to posts_path, alert: "権限がありません" unless @post.user == current_user
    end

    def post_params
      params.require(:post).permit(:title, :body, :category_id, :rating, :image)
    end
  end
end