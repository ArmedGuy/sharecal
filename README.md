# sharecal
'Social network' for event and calendar sharing.

# Design goals

 - Small, easy UX with few options.
 - Scalable syncing options.
 - Minimal administration.

 - Effective and easily deployable stack.

PS. For the sake of this design document, the words user, calendar, and subscriber will be exchanged quite frequently.

By design, a calendar is equal to a user, but with the intent to distribute event to subscribers. (IE a user account is the calendar)

A subscriber is also equal to a user, but with the intent to consume events.

A personal calendar corresponds to the subscriber's personal calendar system that events are synced to. (Not to be confused with a 'calendar')


### For subscribers

Subscribers will be given two options:
 - Sync public events from individual calendars, without having to create your own user account. The problem with this is that you will have to subscribe to each link per calendar manually.

 - Sync all events you are privileged to, and subscribe to new calendars via the web-app. This is the preferred option as you only need to subscribe (via your personal calendar) to your personal link, and it will be updated automatically.


### For calendars (which is any user, really)

You will be able to create public and 'private' events, that gets synced to all subscribers.

Privacy is defined by a simple level system (IE level 0 is public, 1 2 3... is defined by the association)


Benefits for this is instant publication to user calendars.


### Possible issues

#### Calendar spamming
For each calendar(/user), a trust must be had between the subscriber and the calendar. An unserious calendar could fill a personal calendar with spam events.

This must be dealt with in some way.
