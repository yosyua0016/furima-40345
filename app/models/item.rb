class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :ship_area
  belongs_to_active_hash :ship_date
  belongs_to_active_hash :ship_method
  belongs_to :user
  has_one_attached :image

  validates :image, :name, :description, :category_id, :condition_id, :ship_area_id, :ship_date_id, :ship_method_id,
            :price, presence: true
end
