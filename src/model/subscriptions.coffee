module.exports = (app) ->
  Schema = app.locals.db.Schema
  ObjectId = Schema.ObjectId

  Subscription = new Schema
    _subscriber: type: ObjectId, ref: 'User'
    _user: type: ObjectId, ref: 'User'
    level: type: Number, default: 0, min: 0, max: 3

  app.locals.db.model "Subscription", Subscription
