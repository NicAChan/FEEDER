class TeamsController < ApplicationController
  helper_method :check_user_follow_team, :player_role

  def index
    # esport = params[:esport]
    # @all_teams = PandascoreApiService.new("all_teams").get_all_teams
    # @all_teams = PandascoreApiService.new({:slug => 'flash-wolves'}).get_team_by_slug
    # @all_teams = PandascoreApiService.new({:series_id => '1605'}).get_series_teams
    @user = current_user
    @all_teams = Team.all
  end

  def show
    @filtered_future_matches = []
    @filtered_past_matches = []
    team = Team.find(params[:id])
    @team = PandascoreApiService.new({slug: team.slug}).get_team_by_slug.first
    @filtered_future_matches << FilterMatchesByTeamService.new(future_matches, team.slug).filter_matches.flatten
    @filtered_past_matches << FilterMatchesByTeamService.new(past_matches, team.slug).filter_matches.flatten
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

  def future_matches
    @future_matches = PandascoreApiService.new().get_future_matches
  end

  def past_matches
    @past_matches = PandascoreApiService.new().get_past_matches
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
end