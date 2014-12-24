define [
  "app",
  "moment"
  "collections/activity_collection"
  "collections/project_memberships_collection"
  "views/get_api_token_form_view"
  "views/feed_view"
  "hbs!templates/layout"
], (App, moment, ActivityCollection, ProjectMembershipsCollection, GetApiTokenFormView, FeedView, tpl) ->
  Marionette.LayoutView.extend
    template: tpl

    id: "layout"

    regions:
      header: "#header"
      main_content: "#main"

    onRender: ->
      App.commands.setHandler "show:project", (project) =>
        @showProject(project)

    index: ->
      App.memberships = memberships = new ProjectMembershipsCollection()
      App.users = new Backbone.Collection()
      memberships.projectId = 637543

      feed = new ActivityCollection()

      feedView = new FeedView(collection: feed)
      @main_content.show(feedView)

      memberships.fetch
        beforeSend: (xhr) ->
          xhr.setRequestHeader('X-TrackerToken', App.apiToken)
        success: (collection) =>
          people = collection.pluck("person")
          App.users.reset(people)
          feed.fetch
            data:
              occurred_after: @startOfDay()
              limit: 30
            beforeSend: (xhr) ->
              xhr.setRequestHeader('X-TrackerToken', App.apiToken)
            success: (collection) ->
              #console.log(collection)
            error: ->
              console.log("error!")
        error: ->
          console.log("error!")

    getApiToken: ->
      getTokenView = new GetApiTokenFormView
      @main_content.show(getTokenView)

      getTokenView.on "appToken:saved", (token) =>
        App.apiToken = token
        @index()

    startOfDay: ->
      moment().subtract(1, "days").startOf('day').toISOString()
