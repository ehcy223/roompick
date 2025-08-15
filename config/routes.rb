Rails.application.routes.draw do
  namespace :admin do
    get 'categories/index'
    get 'categories/show'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
  end
  #会員用のログイン機能
  devise_for :users,skip: [:passwords], controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }  
  # 管理者用のログイン機能
  devise_for :admins, path: 'admin', skip: [:registrations, :passwords] ,controllers:{
    sessions: 'admin/sessions'
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
      resources :comments, only: [:create, :destroy]
    end
  
    resources :categories, only: [] do
      get 'posts', to: 'posts#categories'  # カテゴリ別投稿一覧
    end
  
    resources :tags, only: [] do
      get 'posts', to: 'posts#tag'         # タグ別投稿一覧
    end
  
    resources :users, only: [:index, :show, :edit, :update] do
      get 'posts', to: 'posts#user_posts'  # ユーザー別投稿一覧
      get 'unsubscribe'  # 退会確認画面
      patch 'withdraw'  # ステータス更新（退会）
    end
  end
  
  # 管理者用ページ
    namespace :admin do
      root to: "homes#top"  # /admin でトップページ
      resources :users,      only: [:index, :show]
      resources :posts,      only: [:index, :show, :destroy]
      resources :comments,   only: [:index, :show]
      resources :tags,       only: [:index, :show]
      resources :categories, only: [:index, :show]
    end
end
