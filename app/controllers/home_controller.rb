class HomeController < ApplicationController
  before_action :user_teams

  helper_method :find_team_logo, :find_team_score, :find_match_date, :get_game_winner

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

  def show
    @match = PandascoreApiService.new().get_match_by_id(params[:id]).first
    @games = @match['games']
    @team1 = Team.where(api_team_id: @match['opponents'].first['opponent']['id']).first
    @team2 = Team.where(api_team_id: @match['opponents'].last['opponent']['id']).first
    
    # render json: @games
  end

  private

  def future_matches    
    all_matches = []
    @future_nalcs_matches = PandascoreApiService.new({league_id: 289}).get_future_matches
    @future_lec_matches = PandascoreApiService.new({league_id: 290}).get_future_matches
    all_matches << @future_nalcs_matches
    all_matches << @future_lec_matches

    all_matches.flatten
  end

  def past_matches
    all_matches = []
    @past_nalcs_matches = PandascoreApiService.new({league_id: 289}).get_past_matches
    @past_lec_matches = PandascoreApiService.new({league_id: 290}).get_past_matches
    all_matches << @past_nalcs_matches
    all_matches << @past_lec_matches

    all_matches.flatten
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
    @date = match['begin_at']
    Date.parse(@date).strftime('%B %d, %Y')
  end

  def get_game_winner(winner_id)
    @winner = PandascoreApiService.new({team_id: winner_id}).get_team_by_id
    @winner.first
  end

end