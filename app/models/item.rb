class Item < ApplicationRecord
  belongs_to :user

  # ActiveStorageのアソシエーション
  has_one_attached :image

end
