class Item < ApplicationRecord
 
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  has_one :order
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :ship_area
  belongs_to_active_hash :ship_date
  belongs_to_active_hash :ship_method


  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id
    validates :condition_id
    validates :ship_area_id
    validates :ship_date_id
    validates :ship_method_id
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :ship_area_id
    validates :ship_date_id
    validates :ship_method_id
  end
end