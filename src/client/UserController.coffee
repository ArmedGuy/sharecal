app = angular.module "ShareCal"
app.controller "UserController", ($scope, $http, $timeout, $routeParams, Notify) ->
  ident = $routeParams.ident

  fetch = ->
    $http.get "/user/#{ident}"
    .success (data) ->
      return Notify.e data if data.error?
      $scope.user = data
  fetch()

  $scope.subscribed = ->
    return false if not $scope.user?
    return false if not ($scope.loggedIn? or $scope.loggedIn or $scope.currentUser?)
    return ($scope.user._subscribers.indexOf ($scope.currentUser._id)) > -1

  $scope.subscribe = ->
    $http.post "/user/#{ident}/subscribe"
    .success (data) ->
      if not data.error?
        Notify.ok "Prenumeration lyckades!", "Du har prenumererat på #{$scope.user.name}"
      else
        Notify.e data
      $timeout fetch, 500
    .error (data) ->
      Notify.error "Nope", "Något gick fel"

  $scope.unsubscribe = ->
    $http.post "/user/#{ident}/unsubscribe"
    .success (data) ->
      if not data.error?
        Notify.ok "Avprenumeration lyckades!", "Du prenumererar inte längre på #{$scope.user.name}"
      else
        Notify.e data
      $timeout fetch, 500
    .error (data) ->
      Notify.error "Nope", "Något gick fel"
