class Party < ApplicationRecord
  has_many :tastings, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :users, through: :invitations
  has_many :wines, through: :tastings

  validates :date, :time, :location, presence: true
  validates_date :date, on: :create, on_or_after: :now
end
