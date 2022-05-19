class Admin < ApplicationRecord
  has_secure_password
  has_many :users

  validates :email, presence: true, uniqueness: true
end
