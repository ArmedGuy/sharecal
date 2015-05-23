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
    verified: Number
    _subscribers: [{type: ObjectId, ref: 'User'}]
    registeredDate: Date

  User.methods.toJSON = ->
    obj = @.toObject()
    obj.access = @.getToken()
    delete obj.password
    obj

  User.methods.getToken = ->
    new Buffer("#{@.ident}:#{@.token}").toString('base64')
      .replace(/\//g, '_').replace(/\+/g, '-')

  app.locals.db.model "User", User
