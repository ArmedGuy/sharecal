app = angular.module "ShareCal"
app.controller "NewEventController", ($scope, $modalInstance, $http) ->
  $scope.today = new Date
  $scope.opened = false
  $scope.format = "yyyy-MM-dd"
  $scope.dateOptions =
    startingDay: 1

  $scope.level = 0
  $scope.openDate = ($event) ->
    $event.preventDefault()
    $event.stopPropagation()
    $scope.opened = true

  $scope.ok = ->
    $modalInstance.close "result"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
