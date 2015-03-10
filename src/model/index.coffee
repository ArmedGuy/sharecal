users = require './users'
events = require './events'
subs = require './subscriptions'

module.exports = (app) ->
    users: users app
    events: events app
    subs: subs app
