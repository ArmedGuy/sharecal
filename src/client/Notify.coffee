app = angular.module "ShareCal"
app.factory 'Notify', ($rootScope) ->
  evt = "ShareCal.Notify"
  error: (title, msg) ->
    $rootScope.$emit evt, type: "error", title: title, message: msg, created: new Date
  warning: (title, msg) ->
    $rootScope.$emit evt, type: "warning", title: title, message: msg, created: new Date
  ok: (title, msg) ->
    $rootScope.$emit evt, type: "ok", title: title, message: msg, created: new Date
  info: (title, msg) ->
    $rootScope.$emit evt, type: "info", title: title, message: msg, created: new Date
  e: (err) ->
    $rootScope.$emit evt, type: "error", title: "Error!", message: err.message, created: new Date
