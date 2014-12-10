define [
  "App",
  "collections/projects_collection"
  "views/get_api_token_form_view"
  "views/project_select_view"
  "views/projects/show_layout"
  "hbs!templates/layout"
], (App, ProjectsCollection,GetApiTokenFormView, ProjectSelectView,
    ProjectShowLayout, tpl) ->
  Marionette.LayoutView.extend
    template: tpl

    id: "layout"

    regions:
      header: "#header"
      main_content: "#main"

    onRender: ->
      App.commands.setHandler "show:project", (project) =>
        @showProject(project)

    getApiToken: ->
      App.navigate("/enter-api-token")
      App.apiToken = "a0368d3b83b45aa779295fd4b26af4a4"
      getTokenView = new GetApiTokenFormView
      @main_content.show(getTokenView)

      getTokenView.on "appToken:saved", =>
        @fetchProjects()

    fetchProjects: ->
      App.navigate("/projects")
      $.ajax
        url: "https://www.pivotaltracker.com/services/v5/projects"
        dataType: "json"
        beforeSend: (xhr) ->
          xhr.setRequestHeader('X-TrackerToken', App.apiToken)
        success: (response) =>
          @showProjectSelectView(response)
        error: (response, status) =>
         debugger


    showProjectSelectView: (response) ->
      projectSelectView = new ProjectSelectView
        collection: new ProjectsCollection(response)
      @main_content.show(projectSelectView)

    showProject: (project) ->
      App.navigate("/projects/#{project.id}")
      view = new ProjectShowLayout
        model: project
      @main_content.show view
