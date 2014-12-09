(function() {
  define(["backbone", "models/update"], function(Backbone, File) {
    return Backbone.Collection.extend({
      model: Update
    });
  });

}).call(this);
