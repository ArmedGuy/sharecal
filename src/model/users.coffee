module.exports = (app) ->
  Schema = app.locals.db.Schema
  ObjectId = Schema.ObjectId

  User = new Schema
    name: String
    ident: type: String, unique: true, match: /[a-zA-Z0-9\-]+/
    email: type: String, unique: true
    password: type: String, match: /.{3,}/
    token: String
    description: String
    registeredDate: Date

  app.locals.db.model "User", User
