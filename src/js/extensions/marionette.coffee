define ["marionette"], (Marionette) ->
  Backbone.Marionette.ItemView.prototype.mixinTemplateHelpers = (target) ->
    self = this
    templateHelpers = Marionette.getOption(self, "templateHelpers")
    result = {}

    target = target || {}

    if _.isFunction(templateHelpers)
      templateHelpers = templateHelpers.call(self)

    _.each(templateHelpers, (helper, index) ->
        if _.isFunction(helper)
          result[index] = helper.call(self)
        else
          result[index] = helper
    )

    return _.extend(target, result)
