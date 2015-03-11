user = require './user'
module.exports = (app) ->

  # Models
  User = app.locals.model.users
  # Public endpoints

  # return session
  app.get '/session', (req, res) ->
    res.json loggedIn: req.session.loggedIn? and req.session.loggedIn

  # Login user
  app.post '/login', (req, res) ->
    email = req.body?.email
    password = req.body?.password
    if not email? or not password?
      res.json error: true, message: "Missing email or password"
    else
      User.findOne
        email: email
        password: password,
        '_id name ident email token registeredDate',
        (err, user) ->
          if err or not user
            res.json error: true, message: "Failed to log in, please try again"
          else
            req.session.loggedIn = true
            req.session.user = user
            res.json loggedIn: true

  # Log user out
  app.post '/logout', (req, res) ->
    if req.session.loggedIn
      req.session.destroy (err) ->
        res.json loggedOut: not err?
    else
      res.json error: true, message: "Must be logged in to log out"

  # Register new user
  app.post '/register', (req, res) ->
    if req.body?
      u = new User req.body
      u.save (err) ->
        if err
          res.json error: true, message: "Could not register, please check your info"
        else
          res.json registered: true
    else
      res.json error: true, message: "Missing information to register"

  # Everything below this is private
  app.use (req, res, next) ->
    if req.session.loggedIn then next() else res.json error: true, message: "Not logged in"

  user(app)

  # Get ICal
  app.get '/share/:cal_ident.ics', (req, res) ->
    raw = req.params.cal_ident.replace(/_/g, '/') + "=="
    data = (new Buffer raw, 'base64').toString()
    res.end data
