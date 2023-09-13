class OrdersController < ApplicationController
  # ログアウト状態で商品購入ページに遷移しようとするユーザーをログインページに遷移
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    # ユーザーが出品者であるか、または商品が売却済みであればトップページへ
    if @item.user_id == current_user.id || @item.order.present?
      redirect_to root_path
    else
      @order_form = OrderForm.new
    end
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    # 商品の情報を受け取る
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,        # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy'             # 通貨の種類(日本円)
    )
  end
end
