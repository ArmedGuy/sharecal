# Routing module
module.exports = (app) ->
  app.get '/', (req, res) ->
    res.end ""

  # Login user or org
  app.post '/login', (req, res) ->
    res.end ""

  # Register new user or org
  app.post '/register', (req, res) ->
    res.end ""

  # Get calendar
  app.get '/calendar/:id', (req, res) ->
    res.end ""

  app.post '/calendar/add', (req,res) ->
    res.end ""

  app.post '/calendar/remove/:id', (req, res) ->
    res.end ""




  # Get ICal
  app.get '/share/:cal_ident.ics', (req, res) ->
    res.end ""
