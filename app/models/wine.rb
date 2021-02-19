class Wine < ApplicationRecord
    has_many :tastings
    has_many :users, through: :tastings
    has_many :parties, through: :tastings
    
    validates :brand, :wine_type, presence: true
    validates :name, presence: {message: "required. If name not unknown, input variety."}
    validates :variety, presence: {message: "required. If variety not unknown, input name."}
    validates :year, presence: {message: "requred. If you don't know the wine year, use the current year."}
end
