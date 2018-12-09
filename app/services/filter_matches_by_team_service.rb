class FilterMatchesByTeamService

  def initialize(matches, team)
    @matches = matches
    @team = team
  end

  def filter_matches
    filtered_array = []
    @matches.each do |match| 
      return filtered_array if match.first == "error" || match.first == "status"
      match['opponents'].each do |opponent|
        if opponent['opponent']['slug'].include?(@team)
          filtered_array << match
        end
      end
    end
    filtered_array
  end

end