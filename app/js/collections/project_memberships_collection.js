(function() {
  define(["backbone"], function(Backbone) {
    return Backbone.Collection.extend({
      url: function() {
        return "https://www.pivotaltracker.com/services/v5/projects/" + this.projectId + "/memberships";
      }
    });
  });

}).call(this);
