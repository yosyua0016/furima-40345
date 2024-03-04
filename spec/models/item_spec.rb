require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
  end

  describe '商品の出品登録' do
    context '商品の出品登録できる場合' do
      it '全ての属性が正しく入力されていれば保存できる' do
        expect(@item).to be_valid
      end
    end

    context '商品の出品登録できない場合' do
      it '１枚画像がないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameが空では保存できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'descriptionが空では保存できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'category_idが「---」だと出品できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end

      it 'condition_idが0では保存できない' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 0')
      end

      it 'ship_area_idが0では保存できない' do
        @item.ship_area_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship area must be other than 0')
      end

      it 'ship_date_idが0では保存できない' do
        @item.ship_date_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship date must be other than 0')
      end

      it 'ship_method_idが0では保存できない' do
        @item.ship_method_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship method must be other than 0')
      end

      it 'priceが300未満では保存できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it 'priceが9,999,999より大きいと保存できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it 'priceが整数でない場合、保存できない' do
        @item.price = 300.5
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be an integer')
      end

      it 'priceが全角数値では保存できないこと' do
        @item.price = '１００１'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'priceが英字では保存できないこと' do
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'priceが英数字混合では保存できないこと' do
        @item.price = '1000yen'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'priceが記号を含む場合は保存できないこと' do
        @item.price = '1,000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'userが紐づいていなければ保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
