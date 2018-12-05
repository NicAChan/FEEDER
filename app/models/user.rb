class User < ApplicationRecord
  validates :first_name
  validates :last_name
  validates :username, uniqueness: true
  validates :email
  has_secure_password


end
