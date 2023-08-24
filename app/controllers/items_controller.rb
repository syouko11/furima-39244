class ItemsController < ApplicationController
  # ログアウト状態のユーザーをログインページへリダイレクト
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    # ログイン状態かつ出品者であれば編集ページへ
    if @item.user_id == current_user.id
      render :edit
    else
    # ログイン状態でも出品者でない場合はトップページへ
      redirect_to root_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      # 編集が完了したら詳細ページへ
      redirect_to item_path
    else
      # 編集に問題がある状態では編集ページへ
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :category_id, :sales_status_id, :shopping_cost_id, :prefecture_id, :shopping_date_id, :price).merge(user_id: current_user.id)
  end
end
