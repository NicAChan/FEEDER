class HomeController < ApplicationController
  before_action :user_teams

  def index
    @followed_team_ids = [] 
    @all_future_matches = []
    if current_user
      current_user.team_followings.each do |team|
        @followed_team_ids << team.team_id
      end
    end
    
    @followed_team_ids.each do |id|
      @all_future_matches << future_matches(Team.find(id).name)
    end

    # render json: future_matches
    # render json: past_matches
    
  end

  def future_matches(team_name)
      @future_matches = PandascoreApiService.new().get_future_matches
      @filtered_future_matches = FilterMatchesByTeamService.new(@future_matches, team_name).filter_matches
  end
  
  def past_matches
    @past_matches = PandascoreApiService.new().get_past_matches
    @filtered_past_matches = FilterMatchesByTeamService.new(@past_matches, 'fnatic').filter_matches
  end

  def user_teams
    [Team.first.slug] # current_user.teams
  end
end
