class PandascoreApiService
  require 'net/http'
  require 'uri'
  attr_accessor :teams

  def initialize(params={})
    @esport = params["esport"]
    # @slug = params[:slug]
    # @series = params[:series_id]
  end

  def uri
    @uri ||= URI.parse("https://api.pandascore.co")
  end

  def get_all_teams
    @all_teams ||= begin
      request("/#{@esport}/teams")
    end 
  end

  def get_team_by_slug
    @team ||= begin
      request("/lol/teams?filter[slug]=#{@slug}")
    end
  end
  # def get_series_teams
  #   # play in group b serie id: 1605
  #   # ex. PandascoreApiService.new({:series_id => '1605'}).get_all_teams
  #   @all_series_teams ||= begin
  #     request("/lol/series/#{@series}/teams")
  #   end
  # end
  
  def get_past_matches
    @all_matches ||= begin
      request("lol/matches/past")
    end
  end
  
  def get_future_matches
    @all_matches ||= begin
      request("lol/matches/upcoming")
    end
  end

  private

  def request(path, body= nil)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri + path)
    request['Content-Type'] = 'application/json'
    request['Authorization'] = ENV['PANDASCORE_API_TOKEN']
    request.body = body if body
    response = http.request(request)
    content = response.body.force_encoding("UTF-8")
    JSON.parse(content)
  end
end