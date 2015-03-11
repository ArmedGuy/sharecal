app = angular.module "ShareCal"

app.config ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: 'partials/index.html'
      controller: 'IndexController'
    .when '/login',
      templateUrl: 'partials/login.html'
      controller: 'LoginController'
    .when '/user/:ident',
      templateUrl: 'partials/user.html'
      controller: 'UserController'
    .otherwise
      redirectTo: '/'
