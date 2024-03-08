FactoryBot.define do
  factory :order_form do
    postal_code { "123-4567" }
    ship_area_id { 1 }
    city { "渋谷区" }
    street { "渋谷109" }
    building { "渋谷ビル101" }
    phone_number { "09012345678" }
    token { "tok_abcdefghijk00000000000000000" }
  end
end