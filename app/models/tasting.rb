class Tasting < ApplicationRecord
  belongs_to :wine
  belongs_to :user
  belongs_to :party

  validates :user, :wine, :party, presence: true
  validates :notes, length: { maximum: 250}
end
