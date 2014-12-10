(function() {
  define(["app", "hbs!templates/get_api_token"], function(app, tpl) {
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
        app.apiToken = this.ui.apiToken.val();
        if (app.apiToken) {
          localStorage.setItem("apiToken", app.apiToken);
          return this.trigger("appToken:saved");
        }
      }
    });
  });

}).call(this);
