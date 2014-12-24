(function() {
  define(["underscore"], function(_) {
    var excluded_fields, fieldLabels, replaceUserIds, userFields;
    excluded_fields = ["accepted_at", "after_id", "before_id", "created_at", "file_attachment_ids", "file_attachments", "google_attachment_ids", "google_attachments", "id", "person_id", "story_id", "text", "updated_at"];
    fieldLabels = {
      "current_state": "Status",
      "owned_by_id": "Owner",
      "owner_ids": "Owners",
      "follower_ids": "Followers"
    };
    userFields = ["owned_by_id", "owner_ids", "follower_ids"];
    replaceUserIds = function(value, users) {
      var initials, newValue, user;
      if (_.isNumber(value)) {
        user = users.get(value);
        initials = user.get("initials");
        value = initials;
      } else if (_.isEmpty(value)) {
        value = "Nobody";
      } else if (_.isArray(value)) {
        newValue = [];
        _(value).each(function(userId) {
          user = users.get(userId);
          initials = user.get("initials");
          return newValue.push(initials);
        });
        value = newValue;
      } else if (_.isNull(value)) {
        value = "Nobody";
      }
      return value;
    };
    return {
      format: function(changes, users) {
        var change, label, new_value, old_value, out, property, _i, _len, _ref;
        out = "<h6>Changes:</h6>";
        out += "<ul class='list-changes'>";
        for (_i = 0, _len = changes.length; _i < _len; _i++) {
          change = changes[_i];
          _ref = change.new_values;
          for (property in _ref) {
            new_value = _ref[property];
            if (!_(excluded_fields).contains(property)) {
              label = fieldLabels[property] || property;
              out += "<li>";
              out += "<span class='change-property-name'>" + label + "</span>";
              if (change.original_values) {
                old_value = change.original_values[property];
              }
              if (_(userFields).contains(property)) {
                old_value = replaceUserIds(old_value, users);
                new_value = replaceUserIds(new_value, users);
              }
              out += "<span class='change-property-value'>";
              out += "" + old_value;
              out += "<i class='fa fa-arrow-right'></i>";
              out += "" + new_value;
              out += "</span>";
              out += "</li>";
            }
          }
        }
        out += "</ul>";
        return out;
      }
    };
  });

}).call(this);
