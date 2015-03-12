app = angular.module 'ShareCal', ['ngRoute', 'ui.bootstrap']

app.controller 'MainController', ($scope) ->
  $scope.hi = "test"
