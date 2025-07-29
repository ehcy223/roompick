Rails.application.routes.draw do
  #エンドユーザー用（会員）用のログイン機能
  devise_for :users,skip: [:passwords], controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }  
  
  #エンドユーザーの各ページ
  scope module: :public do
    root to: 'homes#top'

    get 'mypage' => 'users#mypage', as: 'mypage'
  end
  # 管理者用のログイン機能
  devise_for :admin,skip: [:registrations, :passwords] ,controllers:{
    sessions: 'admin/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
