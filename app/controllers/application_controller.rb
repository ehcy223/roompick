class ApplicationController < ActionController::Base
  #Punditの認可メソッドを利用するための設定
  include Pundit
end
