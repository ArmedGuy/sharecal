module.exports = (app) ->
  Schema = app.locals.db.Schema
  ObjectId = app.locals.db.ObjectId

  User = new Schema
    id: ObjectId
    name: String
    email: String
    token: String
    registeredDate: Date

  app.locals.db.model("User", User)
