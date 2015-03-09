users = require './users'
events = require './events'

module.exports = (app) ->
    users: users app
    events: events app
