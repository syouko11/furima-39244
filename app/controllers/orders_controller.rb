class OrdersController < ApplicationController
  # ログアウト状態で商品購入ページに遷移しようとするユーザーをログインページに遷移
  before_action :authenticate_user!

  def index
    @order_form = OrderForm.new
  end

  def create
    
  end
  
end
