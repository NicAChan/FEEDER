class HomeController < ApplicationController
  before_action :user_teams

  def index
    @all_future_matches = future_matches
    @all_past_matches = past_matches
    @filtered_future_matches = []
    @filtered_past_matches = []

    if current_user
      current_user.team_followings.each do |team|
        @filtered_future_matches << FilterMatchesByTeamService.new(@all_future_matches, team.team.slug).filter_matches.flatten
        @filtered_past_matches << FilterMatchesByTeamService.new(@all_past_matches, team.team.slug).filter_matches.flatten
      end

      @all_filtered_future_matches = @filtered_future_matches.flatten
      @all_filtered_past_matches = @filtered_past_matches.flatten
    end
  end

  private

  def future_matches
      @future_matches = PandascoreApiService.new().get_future_matches
  end

  def past_matches
    @past_matches = PandascoreApiService.new().get_past_matches
  end

  def user_teams
    [Team.first.slug] # current_user.teams
  end
end