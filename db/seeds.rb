# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# teams_slugs = ['solomid', 'cloud9', 'counter-logic-gaming', 'fnatic', 'g2-esports', 'origen', 'sktelecom-t1', 'geng', 'kt-rolster', 'royal-never-give-up', 'edward-gaming', 'invictus-gaming', 'ahq-e-sports-club', 'j-team', 'flash-wolves']

teams_slugs = ['solomid', 'cloud9', 'counter-logic-gaming', 'liquid', '100-thieves', 'echo-fox', 'flyquest', 'clutch-gaming', 'optic-gaming', 'golden-guardians']

teams_slugs.each do |slug|
  team = PandascoreApiService.new({slug: slug}).get_team_by_slug
  new_team = Team.where(slug: team.first['slug']).first_or_initialize
  new_team.assign_attributes({
    name: team.first['name'],
    slug: team.first['slug'],
    league_id: 289,
    api_team_id: team.first['id']
  })
  new_team.save!
end

super_user = User.where(username: 'bobbu').first_or_initialize
super_user.assign_attributes({
    first_name: 'Bob',
    last_name: 'Chan',
    username: 'bobbu',
    email: "bobbu@gmail.com",
    password: 'secret',
    admin: true
})
super_user.save!

p "Created #{Team.all.length} teams!"
p "Created #{User.all.length} user(s)! Creds: bobbu@gmail.com, secret"