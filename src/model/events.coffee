module.exports = (app) ->
  Schema = app.locals.db.Schema
  ObjectId = Schema.ObjectId

  Event = new Schema
    user: type: ObjectId, ref: 'users'
    title: String
    location: String
    description: String
    startDate: Date
    endDate: Date

  app.locals.db.model "Event", Event
