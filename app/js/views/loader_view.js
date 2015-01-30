(function() {
  define(["app", "hbs!templates/loader"], function(App, tpl) {
    return Backbone.Marionette.ItemView.extend({
      template: tpl,
      ui: {
        loader: "#loader"
      },
      initialize: function() {
        return this.projectLoaded = false;
      },
      onShow: function() {
        this.animateQuote();
        return setTimeout((function(_this) {
          return function() {
            return _this.animateQuote();
          };
        })(this), 3000);
      },
      animateQuote: function() {
        var callback, index;
        index = Math.floor((Math.random() * $('#loader li').length) + 1);
        this.newQuote = this.$("#loader li:nth-child(" + index + ")");
        this.activeQuote = this.$("li.active");
        callback = (function(_this) {
          return function() {
            return _this.newQuote.animate({
              opacity: 1
            }, 500, function() {
              return _this.newQuote.addClass("active");
            });
          };
        })(this);
        if (this.activeQuote.length > 0) {
          return this.activeQuote.animate({
            opacity: 0
          }, 250, (function(_this) {
            return function() {
              return callback();
            };
          })(this));
        } else {
          return callback();
        }
      }
    });
  });

}).call(this);
