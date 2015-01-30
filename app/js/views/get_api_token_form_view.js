(function() {
  define(["app", "hbs!templates/get_api_token"], function(App, tpl) {
    return Backbone.Marionette.ItemView.extend({
      template: tpl,
      ui: {
        apiToken: "#js-api-token"
      },
      events: {
        "submit": "storeToken"
      },
      storeToken: function(e) {
        e.preventDefault();
        App.apiToken = this.ui.apiToken.val();
        if (App.apiToken) {
          localStorage.setItem("apiToken", App.apiToken);
          return this.trigger("appToken:saved", App.apiToken);
        }
      }
    });
  });

}).call(this);
