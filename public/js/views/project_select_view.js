(function() {
  define(["app", "views/projects/item_view"], function(app, ProjectItemView) {
    return Backbone.Marionette.CollectionView.extend({
      childView: ProjectItemView
    });
  });

}).call(this);
