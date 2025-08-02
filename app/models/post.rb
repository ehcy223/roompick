class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :body, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
  has_one_attached :image  #画像アップロードを有効にする
end
