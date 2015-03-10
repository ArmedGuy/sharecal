module.exports = (app) ->
  # Models
  User = app.locals.model.users
  Subscription = app.locals.model.subs

  # Get own user data
  app.get '/user', (req, res) ->
    res.json req.session.user

  # Get other user's data
  app.get '/user/:ident', (req, res) ->
    User.findOne ident: req.params.ident, '_id name ident registeredDate'
    (err, user) ->
      if not user? or err?
        res.json error: true, message: "User #{req.params.ident} not found"
      else
        res.json user

  app.get '/user/:ident/subscribers', (req, res) ->
    User.find ident: req.params.ident,
    (err, user) ->
      if not user? or err?
        res.json error: true, message: "User #{req.params.ident} not found"
      else
        Subscription.find _user: user._id
        .populate '_subscriber'
        .exec (err, subs) ->
          if not err?
            res.json (sub._subscriber for sub in subs)
          else
            res.json error: true, message: "Unable to retrieve subscribers"

  app.get '/user/:ident/events', (req, res) ->
    res.end ""

  # Subscribe to user calendar
  app.post '/user/:ident/subscribe', (req, res) ->
    User.findOne ident: req.params.ident,
    (err, user) ->
      if not user? or err?
        res.json error: true, message: "User #{req.params.ident} not found"
      else
        s = new Subscription
          _subscriber: req.session.user._id
          _user: user._id
        s.save (err) ->
          if not err? then res.json subscribed: true else res.json error: true

  # Unsubscribe from calendar
  app.post '/user/:ident/unsubscribe', (req, res) ->
    User.findOne ident: req.params.ident,
    (err, user) ->
      if not user? or err?
        res.json error: true, message: "User #{req.params.ident} not found"
      else
        Subscription.remove
          _subscriber: res.session.user._id
          _user: user._id,
          (err) ->
            res.json unsubscribed: not err?


  # Update user settings
  app.post '/user/settings', (req, res) ->
    res.end ""
