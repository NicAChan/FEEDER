class User < ApplicationRecord
  has_many :team_followings, dependent: :destroy
  has_many :followed_teams, through: :team_followings, source: :team

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  has_secure_password
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
            uniqueness: true,
            format: VALID_EMAIL_REGEX

end
