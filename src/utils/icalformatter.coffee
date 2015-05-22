ical = require 'icalendar'

class Calendar
  constructor: (events) ->
    @.cal = new ical.iCalendar()
    @.cal.addProperty("X-WR-CALNAME", "ShareCal published Calendar")
    @.cal.addProperty("METHOD", "PUBLISH")
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
    evt.addProperty('ORGANIZER', event._owner.name)
    @.cal.addComponent evt

module.exports = Calendar
