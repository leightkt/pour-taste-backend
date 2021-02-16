class Party < ApplicationRecord
  belongs_to :user
  has_many :tastings, dependent: :destroy
  has_many :users, through: :tastings
  has_many :wines, through: :tastings

  validates :user_id, :date, :time, :location, presence: true
end
