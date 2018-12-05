class FilterMatchesByTeamService

  def initialize(matches, team)
    @matches = matches
    @team = team
  end

  def filter_matches
    filtered_array = []
    @matches.each do |match|
      if match['slug'].include?(@team)
        filtered_array << match
      end
    end
    filtered_array
  end

end