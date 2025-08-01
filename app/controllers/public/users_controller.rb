module Public
  class UsersController < ApplicationController
    #ログイン済ユーザーのみアクセス許可
    before_action :authenticate_user!

    # マイページ表示
    def mypage
      @user = current_user
      @posts = @user.posts.order(created_at: :desc)
    end

    # ユーザー情報編集フォーム表示
    def edit
      @user = current_user
    end

    # ユーザー情報更新
    # 更新成功時はマイページにリダイレクト、失敗時は編集画面に戻る

    def update
      @user = current_user
      if @user.update(user_params)
        redirect_to mypage_path, notice: "会員情報を更新しました"
      else
        render :edit
      end
    end
    
    def unsubscribe
      @user = current_user
      # 退会確認ページ表示用アクション
    end

    def withdraw
      @user = current_user
      if @user.update(is_active: false)
        reset_session  # ログアウト処理
        redirect_to new_user_registration_path, notice: "退会が完了しました。ご利用ありがとうございました。"
      else
        render :unsubscribe
      end
    end
    
    private

    # Strong Parametersで許可するユーザー情報の項目を限定
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end