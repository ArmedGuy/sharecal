app = angular.module "ShareCal"
app.controller "LoginController", ($scope, $http, Notify) ->
  $scope.login = ->
    $http.post '/login',
      email: $scope.email
      password: $scope.password
    .success (data) ->
      Notify.e data if data.error?
      if not data.error? and data.loggedIn?
        $scope.$emit "loggedIn"
        Notify.ok "Loggade in", "Du har blivit inloggad"
