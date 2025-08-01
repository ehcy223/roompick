class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :image  #画像アップロードを有効にする
end
