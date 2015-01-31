(function() {
  define(["marionette"], function(Marionette) {
    return Backbone.Marionette.ItemView.prototype.mixinTemplateHelpers = function(target) {
      var result, self, templateHelpers;
      self = this;
      templateHelpers = Marionette.getOption(self, "templateHelpers");
      result = {};
      target = target || {};
      if (_.isFunction(templateHelpers)) {
        templateHelpers = templateHelpers.call(self);
      }
      _.each(templateHelpers, function(helper, index) {
        if (_.isFunction(helper)) {
          return result[index] = helper.call(self);
        } else {
          return result[index] = helper;
        }
      });
      return _.extend(target, result);
    };
  });

}).call(this);
