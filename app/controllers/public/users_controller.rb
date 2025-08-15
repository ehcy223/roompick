# app/controllers/public/users_controller.rb
module Public
  class UsersController < ApplicationController
    # 未ログインでも index/show は見られる
    before_action :authenticate_user!, except: [:index, :show]
    # /users/:id のユーザーを事前取得
    before_action :set_user,           only: [:show, :edit, :update]
    # 本人以外は編集・更新不可
    before_action :ensure_owner!,      only: [:edit, :update]

    def index
      @users = User.order(created_at: :desc)
    end

    def show; end

    def mypage
      @user  = current_user
      @posts = @user.posts.order(created_at: :desc)
    end

    def edit
      # @user は set_user 済み
    end

    def update
      # @user は set_user 済み
      if @user.update(user_params)
        redirect_to mypage_path, notice: "会員情報を更新しました"
      else
        render :edit
      end
    end

    def unsubscribe
      @user = current_user
    end

    def withdraw
      @user = current_user
      if @user.update(is_active: false)
        reset_session
        redirect_to new_user_registration_path, notice: "退会が完了しました。ご利用ありがとうございました。"
      else
        render :unsubscribe
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def ensure_owner!
      redirect_to posts_path, alert: "権限がありません" unless @user == current_user
    end

    def user_params
      # パスワードを空で送ったときは更新しない（任意）
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end