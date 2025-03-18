class Country < ApplicationRecord
    has_many :cities, dependent: :destroy
    
    # 1.6 Validations
    validates :name, presence: true, uniqueness: true
    validates :continent, presence: true
    validates :currency, presence: true
    validates :language, presence: true
  end