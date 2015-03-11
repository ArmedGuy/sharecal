app = angular.module "ShareCal"
app.controller "UserController", ($scope, $http) ->
  $scope.user =
    name: "DDOS - Datatekniks Programförening"
    subscribers: 123
    image: "http://graph.facebook.com/LTUDDOS/picture"

  $scope.events = [
    {type: "event", title: "Solförmörkelse", text: "Yoloswag", date: "3/5"}
    {type: "event", title: "Solförmörkelse", text: "Yoloswag", date: "4/5"}
    {type: "event", title: "Solförmörkelse", text: "Yoloswag", date: "7/5"}
    {type: "event", title: "Solförmörkelse", text: "Yoloswag", date: "12/5"}
    {type: "meeting", title: "Sektionsmöte", text: "Yoloswag", date: "15/5"}
  ]
