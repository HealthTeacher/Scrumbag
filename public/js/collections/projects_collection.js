(function() {
  define(["backbone", "models/project"], function(Backbone, Project) {
    return Backbone.Collection.extend({
      model: Project
    });
  });

}).call(this);
