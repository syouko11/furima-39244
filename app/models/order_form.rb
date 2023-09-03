class OrderForm
  include ActiveModel::Model
  # ordersテーブルとdestinationsテーブルに保存したいカラム名を指定
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    # orderモデルのバリデーション
    validates :user_id
    validates :item_id

    # destinationモデルのバリデーション
    # 郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :prefecture_id
    validates :city
    validates :address
    # 建物名(building)は任意
    # 電話番号は、10桁以上11桁以内の半角数値のみ保存可能
    validates :phone_number, format: {with: /\A[0-9]{10,11}\z/}
  end

  def save
    # 購入情報を保存し、変数orderに代入
    order = Order.create(user_id: user_id, item_id: item_id)
    # 発送先情報を保存(order_idは、変数orderのidと指定)
    Destination.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, order_id: order.id)
  end
end