class Wine < ApplicationRecord
    has_many :tastings
    has_many :users, through: :tastings
    has_many :parties, through: :tastings
    
    validates :brand, :wine_type, presence: true
end
