(function() {
  define(["app", "moment", "../loader_view", "hbs!templates/projects/show_layout"], function(App, moment, LoaderView, tpl) {
    return Marionette.LayoutView.extend({
      template: tpl,
      id: "project-layout",
      regions: {
        main: "#main",
        sidebar: "#sidebar"
      },
      initialize: function(opts) {
        return this.fetchActivity();
      },
      onRender: function() {},
      fetchActivity: function() {
        var url;
        url = "https://www.pivotaltracker.com/services/v5/my/activity";
        return $.ajax({
          url: url,
          dataType: "json",
          data: {
            occurred_after: this.startOfDay(),
            limit: 30
          },
          beforeSend: function(xhr) {
            return xhr.setRequestHeader('X-TrackerToken', App.apiToken);
          },
          success: (function(_this) {
            return function(response) {
              return console.log(response);
            };
          })(this),
          error: (function(_this) {
            return function(response, status) {
              debugger;
            };
          })(this)
        });
      },
      startOfDay: function() {
        return moment().subtract(1, "days").startOf('day').toISOString();
      },
      endOfDay: function() {
        return moment().endOf('day').toISOString();
      }
    });
  });

}).call(this);
