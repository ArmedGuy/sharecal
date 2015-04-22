app = angular.module "ShareCal"
app.controller "NewEventController", ($scope, $modalInstance, $http, Notify) ->
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
    if (not $scope.startTime? or not $scope.endTime?) or $scope.startTime > $scope.endTime
      return Notify.error "Fel tid", "Tiden för eventet är ej giltigt."

    startDate = new Date $scope.date.getTime()
    startDate.setHours $scope.startTime.getHours()
    startDate.setMinutes $scope.startTime.getMinutes()

    endDate = new Date $scope.date.getTime()
    endDate.setHours $scope.endTime.getHours()
    endDate.setMinutes $scope.endTime.getMinutes()

    event =
      title: $scope.title
      type: $scope.type
      description: $scope.description
      location: $scope.location
      startDate: startDate
      endDate: endDate
      level: $scope.level

    $http.post '/event', event
    .success (data) ->
      Notify.e data if data.error?
      if data.created?
        Notify.ok "Nytt event skapat!", "Ditt event har nu skapats."
        $modalInstance.close "result"

  $scope.cancel = ->
    $modalInstance.dismiss "cancel"
