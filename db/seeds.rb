# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


teams_slugs = ['solomid', 'cloud9', 'counter-logic-gaming', 'fnatic', 'g2-esports', 'origen', 'sktelecom-t1', 'geng', 'kt-rolster', 'royal-never-give-up', 'edward-gaming', 'invictus-gaming', 'ahq-e-sports-club', 'j-team', 'flash-wolves']

teams_slugs.each do |slug|
  team = PandascoreApiService.new({slug: slug}).get_team_by_slug
  new_team = Team.where(slug: team.first['slug']).first_or_initialize
  new_team.assign_attributes({
    name: team.first['name'],
    slug: team.first['slug']
  })
  new_team.save!
  # 1) use the slug to find the team's data from pandascore
  # 2) store the data in a variable
  # 3) create or initialize an instance where the slug / teamname is equal to the field in your db
  # 4) set the variables accordingly
  # 5) save
end

p "Created #{teams_slugs.length} teams!"