require 'rails_helper'
require_relative '../../app/models/order_form'

RSpec.describe OrderForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_form = FactoryBot.build(:order_form, user_id: user.id, item_id: item.id)
  end

  context '正常系' do
    it 'すべての値とトークンがあれば保存できる' do
      expect(@order_form).to be_valid
    end

    it '建物名が空でも保存できる' do
      @order_form.building = ''
      expect(@order_form).to be_valid
    end
  end

  context 'バリデーションに失敗する場合' do
    it 'トークンが空では保存できないこと' do
      @order_form.token = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Token can't be blank")
    end

    it '郵便番号が空だと保存できない' do
      @order_form.postal_code = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
    end

    it '郵便番号にハイフンがないと保存できない' do
      @order_form.postal_code = '1234567'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it '都道府県が選択されていないと保存できない' do
      @order_form.ship_area_id = 0
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Ship area can't be blank")
    end

    it '市区町村が空だと保存できない' do
      @order_form.city = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("City can't be blank")
    end

    it '番地が空だと保存できない' do
      @order_form.street = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Street can't be blank")
    end

    it '電話番号が空だと保存できない' do
      @order_form.phone_number = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号にハイフンがあると保存できない' do
      @order_form.phone_number = '090-1234-5678'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number is invalid. Exclude hyphen(-)')
    end

    it '電話番号が12桁以上だと保存できない' do
      @order_form.phone_number = '090123456789'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number is invalid. Exclude hyphen(-)')
    end

    it '電話番号が9桁以下だと保存できない' do
      @order_form.phone_number = '090123456'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number is invalid. Exclude hyphen(-)')
    end

    it 'item_idが空だと保存できない' do
      @order_form.item_id = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Item can't be blank")
    end

    it 'user_idが空だと保存できない' do
      @order_form.user_id = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("User can't be blank")
    end
  end
end
