# README

* App Description
  "FEEDER" is an esports web app that allows users to sign up/sign in and follow esports teams. Based on the teams that the user has followed, the feed on their home page will show info on the teams' upcoming and past matches. The app also allow users to view details of specific matches, team info (players/staff, recent past matches), and edit/update their user info. The app currently only supports League of Legends esport matches with teams from only the "North America League of Legends Championship Series" (NALCS) and the "League of Legends European Championshop" (LEC). More teams and different esports will be added in the future (API dependent). A 'live match score' feature was planned but it requires a paid monthly subscription to the API provider. Implementation of this feature is TBD.

* Ruby, Rails version
  ruby '2.5.1'
  rails '5.2.1'

* API used
  PandaScore

* Run 'bundle' in CLI after downloading the app.

* Database creation
  rails db:create
  rails db:migrate
  rails db:seed

* Run 'rails s' in the CLI. When the server is ready, access the app on http://localhost:1337
