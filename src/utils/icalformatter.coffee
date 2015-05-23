ical = require 'icalendar'

Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output

class Calendar
  constructor: (events) ->
    name = if (e._owner._id for e in events).unique().length == 1 then events[0]._owner.name else "ShareCal"
    @.cal = new ical.iCalendar()
    @.cal.addProperty("METHOD", "PUBLISH")
    @.cal.addProperty("X-WR-CALNAME", name)
    for event in events
      @.createEvent event

  export: ->
    @.cal.toString()

  createEvent: (event) ->
    evt = new ical.VEvent event._id
    evt.setSummary event.title + ", " + event._owner.name
    evt.setDate event.startDate, event.endDate
    evt.setLocation event.location
    evt.setDescription event.description
    evt.addProperty('ORGANIZER', "mailto:#{event._owner.email}", CN: event._owner.name)
    @.cal.addComponent evt

module.exports = Calendar
