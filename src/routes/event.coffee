module.exports = (app) ->
  User = app.locals.model.users
  Subscription = app.locals.model.subs
  Event = app.locals.model.events


  app.post '/event', (req, res) ->
    if req.body?
      e = new Event req.body
      e.save (err) ->
        if err
          res.json error: true, message: err.message
        else
          res.json created: true
