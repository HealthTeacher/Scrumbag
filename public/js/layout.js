(function() {
  define(["app", "moment", "collections/activity_collection", "collections/project_memberships_collection", "views/get_api_token_form_view", "views/feed_view", "hbs!templates/layout"], function(App, moment, ActivityCollection, ProjectMembershipsCollection, GetApiTokenFormView, FeedView, tpl) {
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
      index: function() {
        var feed, feedView, memberships;
        App.memberships = memberships = new ProjectMembershipsCollection();
        App.users = new Backbone.Collection();
        memberships.projectId = 637543;
        feed = new ActivityCollection();
        feedView = new FeedView({
          collection: feed
        });
        this.main_content.show(feedView);
        return memberships.fetch({
          beforeSend: function(xhr) {
            return xhr.setRequestHeader('X-TrackerToken', App.apiToken);
          },
          success: (function(_this) {
            return function(collection) {
              var people;
              people = collection.pluck("person");
              App.users.reset(people);
              return feed.fetch({
                data: {
                  occurred_after: _this.startOfDay(),
                  limit: 30
                },
                beforeSend: function(xhr) {
                  return xhr.setRequestHeader('X-TrackerToken', App.apiToken);
                },
                success: function(collection) {},
                error: function() {
                  return console.log("error!");
                }
              });
            };
          })(this),
          error: function() {
            return console.log("error!");
          }
        });
      },
      getApiToken: function() {
        var getTokenView;
        getTokenView = new GetApiTokenFormView;
        this.main_content.show(getTokenView);
        return getTokenView.on("appToken:saved", (function(_this) {
          return function(token) {
            App.apiToken = token;
            return _this.index();
          };
        })(this));
      },
      startOfDay: function() {
        return moment().subtract(1, "days").startOf('day').toISOString();
      }
    });
  });

}).call(this);
