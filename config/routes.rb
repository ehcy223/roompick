Rails.application.routes.draw do
  #エンドユーザー用Deviseルーティング
  devise_for :users,skip: [:passwords], controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }  
  
  #エンドユーザー用ルーティング
  scope module: :public do
    root to: 'homes#top'

    get 'mypage' => 'users#mypage', as: 'mypage'
  end
  # 管理者用Deviseルーティング
  devise_for :admin,skip: [:registrations, :passwords] ,controllers:{
    sessions: 'admin/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
