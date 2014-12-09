(function() {
  define(["app", "views/get_api_token_form_view", "views/project_select_view", "hbs!templates/layout"], function(app, GetApiTokenFormView, ProjectSelectView, tpl) {
    return Marionette.LayoutView.extend({
      template: tpl,
      id: "layout",
      regions: {
        header: "#header",
        main_content: "#main"
      },
      getApiToken: function() {
        var getTokenView;
        getTokenView = new GetApiTokenFormView;
        return this.main_content.show(view);
      },
      showProjectSelect: function() {
        var projectSelectView;
        projectSelectView = new ProjectSelectView;
        return this.main_content.show(projectSelectView);
      }
    });
  });

}).call(this);
