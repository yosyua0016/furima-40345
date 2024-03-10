FactoryBot.define do
  factory :order_form do
    postal_code   { '123-4567' }
    ship_area_id  { 2 }
    city          { '東京都' }
    street        { '渋谷区神宮前' }
    building      { '渋谷ビル101' }
    phone_number  { '09012345678' }
    token         { 'tok_abcdefghijk00000000000000000' }
  end
end
