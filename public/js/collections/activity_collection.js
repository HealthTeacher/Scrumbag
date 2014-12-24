(function() {
  define(["backbone"], function(Backbone) {
    return Backbone.Collection.extend({
      url: "https://www.pivotaltracker.com/services/v5/my/activity"
    });
  });

}).call(this);
