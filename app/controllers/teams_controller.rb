class TeamsController < ApplicationController
  def index
    esport = params[:esport]
    @all_teams = PandascoreApiService.new("all_teams").get_all_teams
    # @all_teams = PandascoreApiService.new({:slug => 'flash-wolves'}).get_team_by_slug
    
    # @all_teams = PandascoreApiService.new({:series_id => '1605'}).get_series_teams
  end

  def show
  end
end
