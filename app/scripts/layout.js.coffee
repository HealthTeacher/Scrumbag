define [
  "app",
  "views/get_api_token_form_view"
  "views/project_select_view"
  "hbs!templates/layout"
], (app, GetApiTokenFormView, ProjectSelectView, tpl) ->
  Marionette.LayoutView.extend
    template: tpl

    id: "layout"

    regions:
      header: "#header"
      main_content: "#main"

    getApiToken: ->
      getTokenView = new GetApiTokenFormView
      @main_content.show(view)

      #getTokenView.on "appToken:saved", =>
        #@showProjectSelect

    showProjectSelect: ->
      projectSelectView = new ProjectSelectView

      @main_content.show(projectSelectView)

