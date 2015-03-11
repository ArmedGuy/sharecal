app = angular.module "ShareCal"
app.controller "LoginController", ($scope, $http) ->
  $scope.login = ->
    $http.post '/login',
      email: $scope.email
      password: $scope.password
    .success (data) ->
      if not data.error? and data.loggedIn?
        $scope.$emit "loggedIn"
