class TeamFollowing < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates(
    :team_id,
    uniqueness: {
      scope: :user_id,
      message: "already following this team"
    }
  )
end
