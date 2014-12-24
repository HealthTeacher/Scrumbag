(function() {
  define(["app", "helpers/change_formatter", "hbs!templates/feed/item", "hbs!templates/feed/story"], function(App, ChangeFormatter, itemTpl, storyTpl) {
    var FeedItemView;
    FeedItemView = Backbone.Marionette.ItemView.extend({
      template: function(serializedModel) {
        var story;
        story = serializedModel.primary_resources[0];
        story.iconClass = (function() {
          switch (story.story_type) {
            case "feature":
              return "star";
            case "bug":
              return "bug";
            case "chore":
              return "cog";
          }
        })();
        serializedModel.story_summary = storyTpl(story);
        return itemTpl(serializedModel);
      },
      initialize: function(opts) {
        return this.model.set("formatted_changes", ChangeFormatter.format(this.model.get("changes"), App.users));
      },
      tagName: "article",
      className: function() {
        var kind;
        kind = this.model.get("kind");
        return "feed-item item-kind-" + kind;
      }
    });
    return Backbone.Marionette.CollectionView.extend({
      id: "view-feed-view",
      childView: FeedItemView
    });
  });

}).call(this);
