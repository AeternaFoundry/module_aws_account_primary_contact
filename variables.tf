variable "account_primary_contacts" {
  description = <<EOT
Map of account_primary_contacts, attributes below
Required:
    - address_line_1
    - city
    - country_code
    - full_name
    - phone_number
    - postal_code
Optional:
    - account_id
    - address_line_2
    - address_line_3
    - company_name
    - district_or_county
    - state_or_region
    - website_url
EOT

  type = map(object({
    address_line_1     = string
    city               = string
    country_code       = string
    full_name          = string
    phone_number       = string
    postal_code        = string
    account_id         = optional(string)
    address_line_2     = optional(string)
    address_line_3     = optional(string)
    company_name       = optional(string)
    district_or_county = optional(string)
    state_or_region    = optional(string)
    website_url        = optional(string)
  }))
  validation {
    condition = alltrue([
      for k, v in var.account_primary_contacts : (
        length(v.full_name) >= 1 && length(v.full_name) <= 64
      )
    ])
    error_message = "must be between 1 and 64 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.account_primary_contacts : (
        can(regex("^[+][0-9\\s()-]+$", v.phone_number))
      )
    ])
    error_message = "must be a valid phone number"
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

