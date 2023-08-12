class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user

  # ActiveStorageのアソシエーション
  has_one_attached :image

  # ActiveHashのアソシエーション
  belongs_to :category
  belongs_to :sales_status

end
