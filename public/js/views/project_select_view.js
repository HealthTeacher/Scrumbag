(function() {
  define(["app", "collections/projects_collection", "views/projects/item_view", "hbs!templates/project_select"], function(App, ProjectsCollection, ProjectItemView, tpl) {
    return Backbone.Marionette.CompositeView.extend({
      template: tpl,
      childView: ProjectItemView,
      childViewContainer: "#js-project-list",
      triggers: {
        "click": "showProject"
      }
    });
  });

}).call(this);
