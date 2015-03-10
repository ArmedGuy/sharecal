module.exports = (app) ->
  Schema = app.locals.db.Schema
  ObjectId = Schema.ObjectId

  Event = new Schema
    _user: type: ObjectId, ref: 'User'
    title: String
    location: String
    description: String
    startDate: Date
    endDate: Date

  app.locals.db.model "Event", Event
