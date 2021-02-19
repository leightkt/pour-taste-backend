class Party < ApplicationRecord
  has_many :tastings, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :users, through: :invitations
  has_many :wines, through: :tastings

  validates :date, :time, :location, presence: true
  validate :date, :check_date

  def check_date
    if date < (Time.now - 86400)
      errors.add(:date, "can't be in the past")
    end
  end

end
