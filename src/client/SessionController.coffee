app = angular.module "ShareCal"
app.controller "SessionController", ($scope, $http, $timeout, $location, Notify) ->
  $scope.loggedIn = false
  $scope.user = null
  $scope.$on "loggedIn", ->
    checkSession()

  checkSession = ->
    $http.get '/session'
    .success (data) ->
      $scope.loggedIn = data.loggedIn
      if $scope.loggedIn
        $http.get '/user'
        .success (userData) ->
          $scope.user = userData
      $timeout checkSession, 10000
    .error (data, status) ->
      $scope.loggedIn = false
  checkSession()

  $scope.logout = ->
    $http.post '/logout'
    .success (data) ->
      Notify.ok "Loggade ut!", "Du har nu blivit utloggad"
      $scope.loggedIn = false
      $scope.user = null
      $location.path "/"
