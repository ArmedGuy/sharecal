token = require 'rand-token'
user = require './user'
event = require './event'
module.exports = (app) ->

  # Models
  User = app.locals.model.users
  # Update user info on every request
  app.use (req, res, next) ->
    if req.session.loggedIn and req.session.userId?
      User.findOne _id: req.session.userId, (err, user) ->
        req.session.user = user if not err? and user?
        next()
    else
      next()
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
        (err, user) ->
          if err or not user
            res.json error: true, message: "Failed to log in, please try again"
          else
            req.session.loggedIn = true
            req.session.userId = user._id
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
      u.token = token.generate(16)
      u.save (err) ->
        if err
          res.json error: true, message: err.message
        else
          req.session.loggedIn = true
          req.session.userId = u._id
          res.json registered: true
    else
      res.json error: true, message: "Missing information to register"

  # Everything below this is private
  app.use (req, res, next) ->
    return next() if req.method == 'GET' # allow all get requests for now
    if req.session.loggedIn then next() else res.json error: true, message: "Not logged in"

  # Router files
  user app
  event app

  # Get ICal
  app.get '/share/:cal_ident.ics', (req, res) ->
    raw = req.params.cal_ident.replace(/_/g, '/') + "=="
    data = (new Buffer raw, 'base64').toString()
    res.end data
