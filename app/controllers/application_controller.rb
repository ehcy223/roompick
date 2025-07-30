class ApplicationController < ActionController::Base
  #Punditの認可メソッドを利用するための設定
  include Pundit
  # Deviseコントローラのときにパラメータ許可を実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
