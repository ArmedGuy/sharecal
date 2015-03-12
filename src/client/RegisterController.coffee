app = angular.module "ShareCal"
app.controller "RegisterController", ($scope, $http, $location, Notify) ->
  $scope.register = ->
    fel = "Fel vid registrering"
    return Notify.warning fel, "Löseorden stämde inte överrens" if $scope.password != $scope.confirmPassword

    return Notify.warning fel, "E-post stämde inte överrens" if $scope.email != $scope.confirmEmail

    $http.post '/register',
      ident: $scope.username
      name: $scope.name
      email: $scope.email
      password: $scope.password
    .success (data) ->
      Notify.e data if data.error?
      if data.registered?
        Notify.ok "Registrerad!", "Du blir nu inloggad"
        $scope.$emit "loggedIn"
        $location.path "/user"
