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
    
    resources :posts do
      collection do
        get 'search'         # 投稿検索
        get 'my', action: 'my_posts'  # ログインユーザーの投稿一覧
        get 'tag/:tag_name', action: 'tag_filter', as: 'tag_filter'  # タグ絞り込み
      end
    end
  
    resources :categories, only: [] do
      get 'posts', to: 'posts#categories'  # カテゴリ別投稿一覧
    end
  
    resources :tags, only: [] do
      get 'posts', to: 'posts#tag'         # タグ別投稿一覧
    end
  
    resources :users, only: [:edit, :update] do
      get 'posts', to: 'posts#user_posts'  # ユーザー別投稿一覧
      get 'unsubscribe'  # 退会確認画面
      patch 'withdraw'  # ステータス更新（退会）
    end
  end

  # 管理者用のログイン機能
  devise_for :admin,skip: [:registrations, :passwords] ,controllers:{
    sessions: 'admin/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
