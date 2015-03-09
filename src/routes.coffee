# Routing module
module.exports = (app) ->
  app.get '/', (req, res) ->
    res.end ""

  # Login user
  app.post '/login', (req, res) ->
    res.end ""

  # Register new user
  app.post '/register', (req, res) ->
    res.end ""

  # Get user data
  app.get '/user', (req, res) ->
    res.end ""

  # Update user settings
  app.post '/user/settings', (req, res) ->
    res.end ""

  # Subscribe to user calendar
  app.post '/user/subscribe', (req, res) ->
    res.end ""

  # Unsubscribe from calendar
  app.post '/user/unsubscribe', (req, res) ->
    res.end ""


  # Get ICal
  app.get '/share/:cal_ident.ics', (req, res) ->
    res.end ""
