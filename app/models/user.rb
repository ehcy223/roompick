class User < ApplicationRecord
  # Deviseで使えるその他の機能（必要に応じて追加可能）:
# :confirmable（メール確認）, :lockable（アカウントロック）,
# :timeoutable（一定時間でセッション切れ）, :trackable（ログイン履歴）,
# :omniauthable（SNSログイン）
  has_many :posts, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
