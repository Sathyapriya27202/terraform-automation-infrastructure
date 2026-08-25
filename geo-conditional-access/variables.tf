variable "named_location_name"{default="Allowed Countries"}
variable "policy_name"{default="Geo-Based Conditional Access Policy"}
variable "allowed_countries"{type=list(string) default=["IN","US"]}