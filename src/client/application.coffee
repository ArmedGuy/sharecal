app = angular.module 'ShareCal', ['ngRoute', 'ui.bootstrap']

app.config ($locationProvider) ->
  $locationProvider.html5Mode true
  $locationProvider.hashPrefix '!'
