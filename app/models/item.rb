class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :ship_area
  belongs_to_active_hash :ship_date
  belongs_to_active_hash :ship_method
  belongs_to :user
  has_one_attached :image

  validates :image,        presence: true

  validates :name,         presence: true
  validates :description,  presence: true
  validates :category_id,  presence: true, numericality: { other_than: 0 }
  validates :condition_id, presence: true, numericality: { other_than: 0 }
  validates :ship_area_id, presence: true, numericality: { other_than: 0 }
  validates :ship_date_id, presence: true, numericality: { other_than: 0 }
  validates :ship_method_id, presence: true, numericality: { other_than: 0 }
  validates :price,           presence: true,
                              numericality: {
                                only_integer: true,
                                greater_than_or_equal_to: 300,
                                less_than_or_equal_to: 9_999_999
                              }
end
