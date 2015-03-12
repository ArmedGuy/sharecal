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
    _subscribers: [{type: ObjectId, ref: 'User'}]
    registeredDate: Date

  User.methods.toJSON = ->
    obj = @.toObject()
    delete obj.password
    obj

  app.locals.db.model "User", User
