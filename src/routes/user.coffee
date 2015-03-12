module.exports = (app) ->
  # Models
  User = app.locals.model.users
  Subscription = app.locals.model.subs
  Event = app.locals.model.events

  # Get own user data
  app.get '/user', (req, res) ->
    res.json if req.session.loggedIn then req.session.user else null

  # Get other user's data
  app.get '/user/:ident', (req, res) ->
    User.findOne ident: req.params.ident,
    (err, user) ->
      if not user? or err?
        res.json error: true, message: "User #{req.params.ident} not found"
      else
        userObj = user.toJSON()
        delete userObj.email # strip email from public users
        res.json userObj

  app.get '/user/:ident/subscribers', (req, res) ->
    User.findOne ident: req.params.ident,
    (err, user) ->
      if not user? or err?
        res.json error: true, message: "User #{req.params.ident} not found"
      else
        Subscription.find _user: user._id # TODO: make static function in model
        .populate '_subscriber'
        .exec (err, subs) ->
          if not err?
            res.json (sub._subscriber for sub in subs)
          else
            res.json error: true, message: "Unable to retrieve subscribers"

  app.get '/user/:ident/events', (req, res) ->
    User.findOne ident: req.params.ident,
    (err, user) ->
      if not user? or err?
        res.json error: true, message: "User #{req.params.ident} not found"
      else
        Event.find _user: user._id
        .exec(err, events) ->
          if not err?
            res.json events
          else
            res.json error: true, message: "Unable to retrieve events"

  # Subscribe to user calendar
  app.post '/user/:ident/subscribe', (req, res) ->
    User.findOne ident: req.params.ident,
    (err, user) ->
      if not user? or err?
        res.json error: true, message: "User #{req.params.ident} not found"
      else
        user._subscribers.push req.session.user._id
        s = new Subscription
          _subscriber: req.session.user._id
          _user: user._id
        s.save (err) ->
          if not err?
            user.save()
            res.json subscribed: true
          else
            res.json error: true, message: "Failed to subscribe"

  # Unsubscribe from calendar
  app.post '/user/:ident/unsubscribe', (req, res) ->
    User.findOne ident: req.params.ident,
    (err, user) ->
      if not user? or err?
        res.json error: true, message: "User #{req.params.ident} not found"
      else
        try
          user._subscribers.splice user._subscribers.indexOf(req.session.user._id), 1
          user.save (err) ->
            Subscription.remove
              _subscriber: req.session.user._id
              _user: user._id,
              (err) ->
                res.json unsubscribed: not err?
        catch
          res.json error: true, message: "Could not unsubscribe"


  # Update user settings
  app.post '/user/settings', (req, res) ->
    res.end ""
