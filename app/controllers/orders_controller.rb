class OrdersController < ApplicationController
  # ログアウト状態で商品購入ページに遷移しようとするユーザーをログインページに遷移
  before_action :authenticate_user!

  def index
    # 商品の情報を受け取る
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new(order_params)
    binding.pry
    if @order_form.valid?
      @order_form.save
    end
    redirect_to root_path
  end

  private

  def order_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

end
