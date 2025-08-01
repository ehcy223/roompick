class User < ApplicationRecord
  # Deviseで使えるその他の機能（必要に応じて追加可能）:
  # :confirmable（メール確認）, :lockable（アカウントロック）,
  # :timeoutable（一定時間でセッション切れ）, :trackable（ログイン履歴）,
  # :omniauthable（SNSログイン）
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # ユーザーが削除されると関連投稿も削除
  has_many :posts, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
