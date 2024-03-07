require 'rails_helper'

RSpec.describe PurchaseHistoryForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @product = FactoryBot.create(:item)
    @order_form = FactoryBot.build(:purchase_history_form, user_id: @user.id, item_id: @item.id)
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができる場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@purchase_history_form).to be_valid
      end
      it 'user_idが空欄でなければ保存できる' do
        @purchase_history_form.user_id = 1
        expect(@purchase_history_form).to be_valid
      end
      it 'product_idが空欄でなければ保存できる' do
        @purchase_history_form.item_id = 1
        expect(@purchase_history_form).to be_valid
      end
      it '郵便番号が「3桁＋ハイフン＋4桁」の組み合わせであれば保存できる' do
        @purchase_history_form.postal_code = '123-4560'
        expect(@purchase_history_form).to be_valid
      end
      it '都道府県が「---」以外かつ空欄でなければ保存できる' do
        @purchase_history_form.ship_area_id = 1
        expect(@purchase_history_form).to be_valid
      end
      it '市区町村が空欄でなければ保存できる' do
        @purchase_history_form.city = '横浜市'
        expect(@purchase_history_form).to be_valid
      end
      it '番地が空欄でなければ保存できる' do
        @purchase_history_form.street = '旭区１２３'
        expect(@purchase_history_form).to be_valid
      end
      it '建物名が空欄でも保存できる' do
        @purchase_history_form.building_name = nil
        expect(@purchase_history_form).to be_valid
      end
      it '電話番号が11番桁以内かつハイフンなしであれば保存できる' do
        @purchase_history_form.phone_number = 12_345_678_910
        expect(@purchase_history_form).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @purchase_history_form.user_id = nil
        @purchase_history_form.valid?
        expect(@purchase_history_form.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @purchase_history_form.item_id = nil
        @purchase_history_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @purchase_history_form.postal_code = nil
        @purchase_history_form.valid?
        expect(@purchase_history_form.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @purchase_history_form.post_code = '1234567'
        @purchase_history_form.valid?
        expect(@purchase_history_form.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '都道府県が「---」だと保存できないこと' do
        @purchase_history.ship_area_id = 0
        @purchase_history_form.valid?
        expect(@purchase_history_form.errors.full_messages).to include("ShipArea can't be blank")
      end
      it '都道府県が空欄だと保存できないこと' do
        @purchase_history_form.ship_area_id = nil
        @purchase_history_form.valid?
        expect(@purchase_history_form.errors.full_messages).to include("ShipArea can't be blank")
      end
      it '市区町村が空欄だと保存できないこと' do
        @purchase_history_form.city = nil
        @purchase_history_form.valid?
        expect(@purchase_history_form.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空欄だと保存できないこと' do
        @purchase_history_form.street = nil
        @purchase_history_form.valid?
        expect(@purchase_history_form.errors.full_messages).to include("Street can't be blank")
      end
      it '電話番号が空欄だと保存できないこと' do
        @purchase_history_form.phone_number = nil
        @purchase_history_form.valid?
        expect(@purchase_history_form.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @purchase_history_form.phone_number = '123 - 1234 - 1234'
        @purchase_history_form.valid?
        expect(@purchase_history_form.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @purchase_history_form.phone_number = 12_345_678_910_123_111
        @purchase_history_form.valid?
        expect(@purchase_history_form.errors.full_messages).to include('Phone number is invalid')
      end
      it 'トークンが空だと保存できないこと' do
        @purchase_history_form.token = nil
        @purchase_history_form.valid?
        expect(@purchase_history_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end