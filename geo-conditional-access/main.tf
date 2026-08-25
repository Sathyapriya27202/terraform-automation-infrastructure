resource "azuread_named_location" "allowed" {
  display_name=var.named_location_name
  country {
    countries_and_regions=var.allowed_countries
    include_unknown_countries_and_regions=false
  }
}

resource "azuread_conditional_access_policy" "geo" {
  display_name=var.policy_name
  state="enabledForReportingButNotEnforced"

  conditions {
    users { include_users=["All"] }
    applications { include_applications=["All"] }
    locations {
      include_locations=["All"]
      exclude_locations=[azuread_named_location.allowed.id]
    }
  }

  grant_controls {
    operator="OR"
    built_in_controls=["block"]
  }
}
