define [
  "app"
  "moment"
  "collections/activity_collection"
  "collections/project_memberships_collection"
  "views/get_api_token_form_view"
  "views/feed_view"
  "views/filter_view"
  "hbs!templates/layout"
], (App, moment, ActivityCollection, ProjectMembershipsCollection, GetApiTokenFormView, FeedView,
  FilterView, tpl) ->
  Marionette.LayoutView.extend
    template: tpl

    id: "layout"

    regions:
      header: "#header"
      main_content: "#main"
      sidebar_content: "#sidebar"

    onRender: ->
      App.commands.setHandler "show:project", (project) =>
        @showProject(project)

    index: ->
      App.memberships = memberships = new ProjectMembershipsCollection()
      App.users = new Backbone.Collection()
      memberships.projectId = 637543

      App.feed = feed = new ActivityCollection()

      feedView = @feedView = new FeedView(collection: feed)
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
            success: (collection) =>
              @buildFilters()
            error: ->
              console.log("error!")
        error: ->
          console.log("error!")

    buildFilters: ->
      resources = App.feed.pluck("primary_resources")
      resources = _.flatten(resources)
      stories = _(resources).select (resource) ->
        resource.kind == "story"
      filterCollection = new Backbone.Collection(stories)
      filterView = new FilterView(collection: filterCollection)
      @sidebar_content.show(filterView)

      filterView.on "filter-story", (id) =>
        @filterFeed(id)

      filterView.on "clear-filters", (id) =>
        @clearFilters()

    clearFilters: ->
      @feedView.showAll()

    filterFeed: (storyId) ->
      @feedView.filterByStoryId(storyId)

    getApiToken: ->
      getTokenView = new GetApiTokenFormView
      @main_content.show(getTokenView)

      getTokenView.on "appToken:saved", (token) =>
        App.apiToken = token
        @index()

    startOfDay: ->
      moment().subtract(1, "days").startOf('day').toISOString()
