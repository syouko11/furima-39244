require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: user)
  end

  describe '商品出品登録' do
    context '登録できる場合' do
      it 'すべての入力項目が存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '登録できない場合' do
      it 'userが紐づいていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
      it '商品画像が空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明が空では登録できない' do
        @item.introduction = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Introduction can't be blank")
      end
      it 'カテゴリーが空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Category is not a number', "Category can't be blank")
      end
      it 'カテゴリーが「---」では登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end
      it '商品の状態が空では登録できない' do
        @item.sales_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Sales status is not a number', "Sales status can't be blank")
      end
      it '商品の状態が「---」では登録できない' do
        @item.sales_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Sales status must be other than 0')
      end
      it '配送料の負担が空では登録できない' do
        @item.shopping_cost_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Shopping cost is not a number', "Shopping cost can't be blank")
      end
      it '配送料の負担が「---」では登録できない' do
        @item.shopping_cost_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Shopping cost must be other than 0')
      end
      it '発送元の地域が空では登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture is not a number', "Prefecture can't be blank")
      end
      it '発送元の地域が「---」では登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 0')
      end
      it '発送までの日数が空では登録できない' do
        @item.shopping_date_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Shopping date is not a number', "Shopping date can't be blank")
      end
      it '発送までの日数が「---」では登録できない' do
        @item.shopping_date_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Shopping date must be other than 0')
      end
      it '価格が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", 'Price is not a number')
      end
      it '価格が300円以下では登録できない' do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '価格が9,999,999円以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it '価格が半角数値ではないと登録できない' do
        @item.price = '５０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
