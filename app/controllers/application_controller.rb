class ApplicationController < ActionController::Base
  #Punditの認可メソッドを利用するための設定
  include Pundit
  # Deviseコントローラのときにパラメータ許可を実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path   # 管理者は管理画面TOPへ
    when User
      mypage_path       # 会員はマイページへ
    else
      root_path
    end
  end

  # 新規登録後の遷移先（会員のみ）
  def after_sign_up_path_for(resource)
    if resource.is_a?(User)
      mypage_path
    else
      root_path
    end
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
