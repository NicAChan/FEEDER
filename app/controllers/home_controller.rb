class HomeController < ApplicationController
  before_action :user_teams

  helper_method :find_team_logo, :find_team_score, :find_match_date

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

  def find_team_logo(team)
    team['opponent']['slug']
  end

  def find_team_score(results, team)
    @team_id = team['opponent']['id']
    if results.first['team_id'] == @team_id
      return results.first['score']
    else results.second['team_id'] == @team_id
      return results.second['score']
    end
  end

  def find_match_date(match)
    @date = match['live']['opens_at']
    Date.parse(@date).strftime('%B %d, %Y')
  end
end