class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user

  # ActiveStorageのアソシエーション
  has_one_attached :image

  # ActiveHashのアソシエーション
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shopping_cost
  belongs_to :prefecture
  belongs_to :shopping_date

  # ジャンルの選択が「---」の時は保存できないようにする
  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :sales_status_id
    validates :shopping_cost_id
    validates :prefecture_id
    validates :shopping_date_id
  end

  # 空では保存できない
  with_options presence: true do
    validates :image
    validates :name
    validates :introduction
    validates :category_id
    validates :sales_status_id
    validates :shopping_cost_id
    validates :prefecture_id
    validates :shopping_date_id
    # 価格が300~9,999,999円であること。
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }
  end
end
