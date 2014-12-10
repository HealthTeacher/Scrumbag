(function() {
  define(["App", "collections/projects_collection", "views/get_api_token_form_view", "views/project_select_view", "views/projects/show_layout", "hbs!templates/layout"], function(App, ProjectsCollection, GetApiTokenFormView, ProjectSelectView, ProjectShowLayout, tpl) {
    return Marionette.LayoutView.extend({
      template: tpl,
      id: "layout",
      regions: {
        header: "#header",
        main_content: "#main"
      },
      onRender: function() {
        return App.commands.setHandler("show:project", (function(_this) {
          return function(project) {
            return _this.showProject(project);
          };
        })(this));
      },
      getApiToken: function() {
        var getTokenView;
        App.navigate("/enter-api-token");
        App.apiToken = "a0368d3b83b45aa779295fd4b26af4a4";
        getTokenView = new GetApiTokenFormView;
        this.main_content.show(getTokenView);
        return getTokenView.on("appToken:saved", (function(_this) {
          return function() {
            return _this.fetchProjects();
          };
        })(this));
      },
      fetchProjects: function() {
        App.navigate("/projects");
        return $.ajax({
          url: "https://www.pivotaltracker.com/services/v5/projects",
          dataType: "json",
          beforeSend: function(xhr) {
            return xhr.setRequestHeader('X-TrackerToken', App.apiToken);
          },
          success: (function(_this) {
            return function(response) {
              return _this.showProjectSelectView(response);
            };
          })(this),
          error: (function(_this) {
            return function(response, status) {
              debugger;
            };
          })(this)
        });
      },
      showProjectSelectView: function(response) {
        var projectSelectView;
        projectSelectView = new ProjectSelectView({
          collection: new ProjectsCollection(response)
        });
        return this.main_content.show(projectSelectView);
      },
      showProject: function(project) {
        var view;
        App.navigate("/projects/" + project.id);
        view = new ProjectShowLayout({
          model: project
        });
        return this.main_content.show(view);
      }
    });
  });

}).call(this);
