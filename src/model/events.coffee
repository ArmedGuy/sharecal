module.exports = (app) ->
  Schema = app.locals.db.Schema
  ObjectId = Schema.ObjectId

  Event = new Schema
    _owner: type: ObjectId, ref: 'User'
    type: String
    title: type: String, match: /.{4,256}/
    location: type: String, match: /.{2,128}/
    description: String
    startDate: Date,
    endDate: Date
    level: type: Number, min: 0, max: 100

  app.locals.db.model "Event", Event
