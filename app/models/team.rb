class Team < ApplicationRecord
  has_many :team_followings, dependent: :destroy
  has_many :followers, through: :team_followings, source: :user

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  validates :league_id, presence: true
  validates :api_team_id, presence: true, uniqueness: true
end
