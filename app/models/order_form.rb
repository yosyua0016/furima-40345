class OrderForm
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :ship_area_id, :city, :street, :building, :phone_number, :token

  belongs_to :user

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :ship_area_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :street
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :token
  end

  def save
    order = Order.create(user_id:, item_id:)
    Address.create(order_id: order.id, postal_code:, ship_area_id:, city:, street:,
                   building:, phone_number:)
  end
end
