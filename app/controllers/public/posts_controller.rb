module Public
  class PostsController < ApplicationController
    # 権限チェック
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update, :destroy]

    # 投稿一覧
    def index
      @posts = Post.order(created_at: :desc).page(params[:page]).per(12)
    end

    # ユーザー別投稿一覧 /users/:user_id/posts
    def user_posts
      @user  = User.find(params[:user_id])
      @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(12)
      render :index   # 一覧ビューを流用（専用ビューを作るなら render :user_posts に）
    end
    
    # 投稿詳細表示アクション
    def show
      # @post は set_post で取得済み
    end
    
    # 新規投稿フォーム表示
    def new
      @post = Post.new
    end
    
    # 投稿作成処理
    def create
      # current_userに紐づく新規投稿を受け取ったパラメータで初期化
      @post = current_user.posts.new(post_params)
    
      # 投稿保存成功時の処理
      if @post.save
        # 投稿詳細ページへリダイレクトし、成功メッセージを表示
        redirect_to @post, notice: '投稿が作成されました'
      else
        # バリデーションエラーなどで保存失敗したら、再度新規投稿フォームを表示
        render :new
      end
    end

    # 投稿編集フォーム表示
    def edit
      # @post は set_post 済み（correct_user も通過済み）
    end

    # 投稿更新処理
    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to @post, notice: '投稿が更新されました'
      else
        render :edit
      end
    end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to posts_path, notice: '投稿が削除されました'
    end
    
    #投稿検索
    def search
      keyword = params[:keyword]
      @posts = if keyword.present?
                 Post.where("title LIKE ?", "%#{keyword}%").order(created_at: :desc)
               else
                 Post.all.order(created_at: :desc)
               end
      render :index
    end
    
    private
    def set_post
      @post = Post.find(params[:id])
    end

    # 現在のユーザーが投稿の所有者かを確認し、違えば投稿一覧へリダイレクトする
    def correct_user
      # set_post 済み
      redirect_to posts_path, alert: "権限がありません" unless @post.user == current_user
    end

    # ストロングパラメータ：投稿で受け取る安全なパラメータを限定
    def post_params
      params.require(:post).permit(:title, :body, :category_id, :rating, :image)
    end
  end
end
  