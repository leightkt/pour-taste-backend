class Wine < ApplicationRecord
    has_many :tastings
    has_many :users, through: :tastings
    has_many :parties, through: :tastings
    
    validates :brand, :wine_type, :year, presence: true
    validates :name, presence: {message: "required. If name not unknown, input variety."}
    validates :variety, presence: {message: "required. If variety not unknown, input name."}
end
