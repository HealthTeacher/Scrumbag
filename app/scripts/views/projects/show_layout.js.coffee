define [
  "app"
  "moment"
  "../loader_view"
  "hbs!templates/projects/show_layout"
], (App, moment, LoaderView, tpl) ->
  Marionette.LayoutView.extend
    template: tpl

    id: "project-layout"

    regions:
      main: "#main"
      sidebar: "#sidebar"

    initialize: (opts) ->
      @fetchActivity()

    onRender: ->

    fetchActivity: ->
      url = "https://www.pivotaltracker.com/services/v5/my/activity"
      $.ajax
        url: url
        dataType: "json"
        data:
          occurred_after: @startOfDay()
          limit: 30
        beforeSend: (xhr) ->
          xhr.setRequestHeader('X-TrackerToken', App.apiToken)
        success: (response) =>
        error: (response, status) =>
         debugger

    startOfDay: ->
      moment().subtract(1, "days").startOf('day').toISOString()

    endOfDay: ->
      moment().endOf('day').toISOString()


