class User < ApplicationRecord
    has_secure_password
    has_many :invitations, dependent: :destroy
    has_many :tastings, dependent: :destroy
    has_many :wines, through: :tastings
    has_many :parties, through: :invitations

    validates :name, :username, :password, :email, presence: true
    validates :username, :email, uniqueness: {message: "should be unique and %{value} is taken."}
    validates :username, :password, length: { in: 6..12}
    validates :password, format: {with: /[\d]/, message: "password must include at least 1 number"}
    validates :password, format: {with: /[A-Z]/, message: "password must include at least 1 uppercase letter"}
    validates :email, format: { with: /[@]/, message: "must be a valid email"}

end
