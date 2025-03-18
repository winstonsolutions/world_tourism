class Attraction < ApplicationRecord
  belongs_to :city
  
  # 1.6  Validations
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :entrance_fee, numericality: { greater_than_or_equal_to: 0 }
end