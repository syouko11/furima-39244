require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @order_form = FactoryBot.build(:order_form)
  end

  describe '発送先情報' do
    context '発送先情報が保存できる場合' do
      it 'すべての入力項目が存在すれば保存できる' do
        expect(@order_form).to be_valid
      end
    end

    context '発送先情報が保存できない場合' do
      it '郵便番号が空では保存できない' do
        @order_form.postal_code = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号が「3桁ハイフン4桁」の半角文字列でないと保存できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code is invalid")
      end
      it '都道府県が空では保存できない' do
        @order_form.prefecture_id = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が「---」では保存できない' do
        @order_form.prefecture_id = 0
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture must be other than 0")
      end
      it '市区町村が空では保存できない' do
        @order_form.city = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空では保存できない' do
        @order_form.address = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空では保存できない' do
        @order_form.phone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が10桁以上11桁以内の半角数値でないと保存できない' do
        @order_form.phone_number = '090-1234-5678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end 
end
