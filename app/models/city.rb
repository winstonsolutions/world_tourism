class City < ApplicationRecord
  belongs_to :country
  has_many :attractions, dependent: :destroy
  
  # 1.6  Validations
  validates :name, presence: true
  validates :is_capital, inclusion: { in: [true, false] }
  validates :population, numericality: { greater_than: 0 }
end