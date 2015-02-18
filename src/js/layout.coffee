define [
  "app"
  "moment"
  "collections/activity_collection"
  "collections/project_memberships_collection"
  "views/loading_view"
  "views/get_api_token_form_view"
  "views/feed_view"
  "views/filter_view"
  "hbs!templates/layout"
], (App, moment, ActivityCollection, ProjectMembershipsCollection, LoadingView, GetApiTokenFormView,
    FeedView, FilterView, tpl) ->
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

      loadingView = new LoadingView()
      @main_content.show(loadingView)

      memberships.fetch
        beforeSend: (xhr) ->
          xhr.setRequestHeader('X-TrackerToken', App.apiToken)
        success: (collection) =>
          people = collection.pluck("person")
          App.users.reset(people)
          feed.fetch
            data:
              occurred_after: @startOfDay()
              limit: 100
            beforeSend: (xhr) ->
              xhr.setRequestHeader('X-TrackerToken', App.apiToken)
            success: (collection) =>
              @buildFilters()
              @main_content.show(feedView)
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
      # if Monday, go back to Friday
      daysAgo = if moment().day() == 1 then 3 else 1
      moment().subtract(daysAgo, "days").startOf("day").toISOString()
