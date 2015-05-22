ical = require '../utils/icalformatter'
module.exports = (app) ->
  User = app.locals.model.users
  Subscription = app.locals.model.subs
  Event = app.locals.model.events


  app.post '/event', (req, res) ->
    if req.body?
      e = new Event req.body
      e._owner = req.session.user._id
      e.save (err) ->
        if err
          res.json error: true, message: err.message
        else
          res.json created: true

  app.get '/events/feed/:ident.ics', (req, res) -> # public feed of user
    User.findOne
      ident: req.params.ident
      (err, user) ->
        if not user? or err?
          return res.end "Hopefully this triggers an invalid calendar format on your end! ;) This user doesn't exist!"
        Event.find
          _owner: user._id
          level: 0
        .sort "startDate"
        .populate '_owner'
        .exec (err, events) ->
          cal = new ical(events)
          res.end cal.export()

  app.get '/events/:ident_str', (req, res) ->
    id = new Buffer(req.params.ident_str.replace(/_/g, '/').replace(/\-/g, '+'), 'base64')
    parts = id.split(":")
