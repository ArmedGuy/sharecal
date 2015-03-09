module.exports = (app) ->
  Schema = app.locals.db.Schema
  ObjectId = Schema.ObjectId

  User = new Schema
    name: String
    ident: type: String, unique: true
    email: type: String, unique: true
    password: String
    token: String
    registeredDate: Date

  app.locals.db.model "User", User
