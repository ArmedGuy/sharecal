app = angular.module "ShareCal"
app.controller "SessionController", ($scope, $http, $timeout, $location, $modal, Notify) ->
  $scope.loggedIn = false
  $scope.currentUser = null
  $scope.verified = {}
  $http.get '/verified.json'
  .success (data) ->
    $scope.verified = data
  $scope.$on "loggedIn", ->
    checkSession()

  checkSession = ->
    $http.get '/session'
    .success (data) ->
      $scope.loaded = true
      $scope.loggedIn = data.loggedIn
      if $scope.loggedIn
        $http.get '/user'
        .success (userData) ->
          $scope.currentUser = userData
      $timeout checkSession, 10000
    .error (data, status) ->
      $scope.loggedIn = false
  checkSession()

  $scope.isCurrentUser = (user) ->
    return false if not user? or not $scope.currentUser?
    return user._id == $scope.currentUser._id

  $scope.logout = ->
    $http.post '/logout'
    .success (data) ->
      Notify.ok "Loggade ut!", "Du har nu blivit utloggad"
      $scope.loggedIn = false
      $scope.currentUser = null
      $location.path "/"

  $scope.getSubscribeLink = ->
    prompt("Länk", "http://localhost:3000/events/feed/" + $scope.currentUser.access + ".ics")
  $scope.newEvent = ->
    inst = $modal.open
      templateUrl: 'partials/event_new.html'
      controller: 'NewEventController'
      backdrop: 'static'
      keyboard: true

    inst.result.then (res) ->
