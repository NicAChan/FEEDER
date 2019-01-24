class TeamsController < ApplicationController
  helper_method :check_user_follow_team, :player_role, :find_team_score, :find_match_date

  def index
    # esport = params[:esport]
    # @all_teams = PandascoreApiService.new("all_teams").get_all_teams
    # @all_teams = PandascoreApiService.new({:slug => 'flash-wolves'}).get_team_by_slug
    # @all_teams = PandascoreApiService.new({:series_id => '1605'}).get_series_teams
    @user = current_user
    @all_teams = Team.all
    @nalcs_teams = Team.where(league_id: 4198)
    @lec_teams = Team.where(league_id: 4197)
  end

  def show
    @filtered_future_matches = []
    @filtered_past_matches = []
    team = Team.find(params[:id])
    @team = PandascoreApiService.new({slug: team.slug}).get_team_by_slug.first

    if FilterMatchesByTeamService.new(future_matches(team.league_id), team.slug).present?
      @filtered_future_matches << FilterMatchesByTeamService.new(future_matches(team.league_id), team.slug).filter_matches.flatten
    end

    if FilterMatchesByTeamService.new(past_matches(team.league_id), team.slug).present?
      @filtered_past_matches << FilterMatchesByTeamService.new(past_matches(team.league_id), team.slug).filter_matches.flatten
    end
  end


  def update_user_followed_teams
    all_teams = params[:name]
    @user = User.find(session[:user_id])

    all_teams.each do |team|
      follow_team = Team.find_by_slug(team.first)
      if team.second == "1" && @user.followed_teams.find_by_slug(team.first).blank?
        TeamFollowing.create!(user_id: @user.id, team_id: follow_team.id)
      elsif team.second == "0"
        team_follow = TeamFollowing.where(user_id: @user.id, team_id: follow_team.id)
        if team_follow.first.present?
          TeamFollowing.destroy(team_follow.first.id)
        end
      end
    end
    redirect_to root_path
  end


  def check_user_follow_team(slug)
    @user = current_user
    if @user.followed_teams.find_by_slug(slug).present?
      true
    else
      false
    end
  end

  private

  def future_matches(league_id)
    @future_matches = PandascoreApiService.new({league_id: league_id}).get_future_matches
  end

  def past_matches(league_id)
    @past_matches = PandascoreApiService.new({league_id: league_id}).get_past_matches
  end

  def player_role(role)
    case role
    when "mid"
      "Mid"
    when "top"
      "Top"
    when "adc"
      "AD Carry"
    when "jun"
      "Jungle"
    when "sup"
      "Support"
    else
      "Coach"
    end
  end

  def find_match_date(match)
    @date = match['begin_at']
    Date.parse(@date).strftime('%B %d, %Y')
  end

  def find_team_score(results, team)
    @team_id = team['opponent']['id']
    if results.first['team_id'] == @team_id
      return results.first['score']
    else results.second['team_id'] == @team_id
      return results.second['score']
    end
  end  
end