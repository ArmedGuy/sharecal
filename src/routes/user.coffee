module.exports = (app) ->
  # Get user data
  app.get '/user/:ident', (req, res) ->
    app.locals.model.users.findOne ident: req.params.ident
    .select 'id ident name'
    .exec (err, user) ->
      if not user? or err
        res.json error: true, message: "User #{req.params.ident} not found"
      else
        res.json user

  # Update user settings
  app.post '/user/settings', (req, res) ->
    res.end ""

  # Subscribe to user calendar
  app.post '/user/subscribe', (req, res) ->
    res.end ""

  # Unsubscribe from calendar
  app.post '/user/unsubscribe', (req, res) ->
    res.end ""
