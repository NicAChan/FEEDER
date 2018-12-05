class HomeController < ApplicationController
  before_action :user_teams

  def index
    # future_matches
    render json: past_matches
    
  end

  def future_matches
    user_teams.each do |team|
      @future_matches = PandascoreApiService.new("future_matches").get_future_matches
    end
  end
  
  def past_matches
    @past_matches = PandascoreApiService.new().get_past_matches
    @filtered_past_matches = FilterMatchesByTeamService.new(@past_matches, 'fnatic').filter_matches
  end

  def user_teams
    [Team.first.slug] # current_user.teams
  end
end
