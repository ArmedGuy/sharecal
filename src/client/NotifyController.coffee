app = angular.module "ShareCal"
app.controller "NotifyController", ($scope, $rootScope, $timeout) ->
  $scope.notifications = []
  $scope.notificationRead = (ntc) ->
    $timeout.cancel ntc._removeTimer
    $scope.notifications.splice ($scope.notifications.indexOf ntc), 1
  $rootScope.$on "ShareCal.Notify", (event, notification) ->
    notification._removeTimer =
      $timeout (-> $scope.notifications.splice ($scope.notifications.indexOf notification), 1), 6000
    $scope.notifications.push notification
