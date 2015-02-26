define [
  "app"
  "moment"
  "collections/activity_collection"
  "collections/stories_collection"
  "collections/project_memberships_collection"
  "views/loading_view"
  "views/get_api_token_form_view"
  "views/feed_view"
  "views/filter_view"
  "hbs!templates/layout"
], (App, moment, ActivityCollection, StoriesCollection, ProjectMembershipsCollection, LoadingView,
    GetApiTokenFormView, FeedView, FilterView, tpl) ->
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
      App.users = new Backbone.Collection()
      App.memberships = new ProjectMembershipsCollection()
      App.feed = new ActivityCollection()
      App.stories = new StoriesCollection()

      loadingView = new LoadingView()
      @main_content.show(loadingView)

      App.memberships.fetch
        beforeSend: (xhr) ->
          xhr.setRequestHeader('X-TrackerToken', App.apiToken)
        success: (collection) =>
          people = collection.pluck("person")
          App.users.reset(people)
          App.feed.fetch
            data:
              occurred_after: @startOfDay()
              limit: 100
            beforeSend: (xhr) ->
              xhr.setRequestHeader('X-TrackerToken', App.apiToken)
            success: (collection) =>
              @extractResources()
              @buildActivity()
              @buildFilters()
            error: ->
              console.log("error!")
        error: ->
          console.log("error!")

    extractResources: ->
      resources = App.feed.pluck("primary_resources")
      @resources = _.flatten(resources)

      stories = _(@resources).select (resource) ->
        resource.kind == "story"
      @stories = _.uniq(stories, (story) -> story.id)

    buildActivity: ->
      _.each @stories, (story) ->
        activity = App.feed.select (item) ->
          primary_resources = item.get("primary_resources")
          _.pluck(primary_resources, "id").indexOf(story.id) >= 0
        story.activity = activity

      App.stories.reset(@stories)
      @feedView = new FeedView(collection: App.stories)
      @main_content.show(@feedView)

    buildFilters: ->
      filterCollection = new Backbone.Collection(@stories)
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
