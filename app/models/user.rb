class User < ApplicationRecord
  has_secure_password

  belongs_to :admin
  belongs_to :account

  validates :email, presence: true, uniqueness: { scope: :admin }

  def jwt_token
    'asdf'
  end
end
