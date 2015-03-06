define [
  "underscore"
  "moment"
], (_, moment) ->

  excluded_fields = [
    "accepted_at"
    "after_id"
    "before_id"
    "created_at"
    "file_attachment_ids"
    "file_attachments"
    "google_attachment_ids"
    "google_attachments"
    "id"
    "label_ids"
    "owned_by_id"
    "person_id"
    "project_id"
    "story_id"
    "text"
    "updated_at"
  ]

  fieldLabels =
    "current_state": "Status"
    "description": "Description"
    "estimate": "Estimate"
    "follower_ids": "Followers"
    "name": "Name"
    "owner_ids": "Owner"
    "requested_by_id": "Requester"
    "story_type": "Type"

  userFields = [
    "follower_ids"
    "owned_by_id"
    "owner_ids"
    "requested_by_id"
  ]

  replaceUserIds = (value, users) ->
    if _.isNumber(value)
      user = users.get(value)
      initials = user.get("initials")
      value = initials
    else if _.isEmpty(value)
      value = "Nobody"
    else if _.isArray(value)
      newValue = []
      _(value).each (userId) ->
        user = users.get(userId)
        initials = user.get("initials")
        newValue.push(initials)
      value = newValue
    else if _.isNull(value)
      value = "Nobody"

    value

  {
    format: (activities, users) ->
      out = ""
      for activity in activities
        showChanges = true
        changes = activity.get("changes")
        for change in changes
          changeKeys = _.keys(change.new_values)
          showChanges = false if _.intersection(changeKeys, excluded_fields).length == changeKeys.length
        continue unless showChanges

        formattedTimeStamp = moment(activity.get("occurred_at")).format("MM/DD/YYYY h:mma")
        out += "<h6>Changes <em>#{formattedTimeStamp}</em></h6>"
        out += "<ul class='list-changes'>"
        for change in changes
          for property, new_value of change.new_values
            unless _(excluded_fields).contains(property)
              label = fieldLabels[property] || property
              out += "<li>"
              out += "<span class='change-property-name'>#{label}</span>"

              if change.original_values
                old_value = change.original_values[property]
              else
                old_value = "[blank]"

              if _(userFields).contains(property)
                old_value = replaceUserIds(old_value, users)
                new_value = replaceUserIds(new_value, users)

              out += "<span class='change-property-value'>"
              out += "#{old_value}"
              out += "<i class='fa fa-arrow-right'></i>"
              out += "#{new_value}"
              out += "</span>"

              out += "</li>"

        out += "</ul>"

      out
  }
