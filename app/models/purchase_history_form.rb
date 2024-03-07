class PurchaseHistoryForm
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :ship_area_id, :city, :street, :building_name, :phone_number, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :ship_area_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :city
    validates :street
    validates :phone_number, format: { with: /\A\d{10,11}\z/,message: "is invalid. Include hyphen(-)"}
    validates :token
  end

  def save
    purchase_history = PurchaseHistory.create(user_id: user_id, item_id: item_id)
    Address.create(purchase_history_id: purchase_history.id, postal_code: postal_code, ship_area_id: ship_area_id, city: city, street: street, building_name: building_name, phone_number: phone_number)
  end
end