module.exports = (app) ->
  Schema = app.locals.db.Schema
  ObjectId = app.locals.db.ObjectId

  Event = new Schema
    id: ObjectId
    userId: ObjectId
    title: String
    location: String
    description: String
    startDate: Date
    endDate: Date

  app.locals.db.model("Event", Event)
