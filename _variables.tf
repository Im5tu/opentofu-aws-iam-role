variable "name" {
  type        = string
  description = "The name of the role"
  default     = null
}

variable "name_prefix" {
  type        = string
  description = "The name prefix of the role"
  default     = null
}

variable "path" {
  type        = string
  description = "The path the role is stored in"
  default     = ""
}

variable "description" {
  type        = string
  description = "The description of the role"
  default     = null
}

variable "max_session_duration" {
  type        = number
  description = "Maximum session duration (in seconds) for the role, defaults to 1 hour"
  default     = null
}

variable "permission_boundary" {
  type        = string
  description = "The permission boundary to apply to the role"
  default     = null
}

variable "assume_role_services" {
  type        = list(string)
  description = "List of AWS Services that can assume the role"
  default     = []
}

variable "assume_role_arns" {
  type        = list(string)
  description = "List of Account IDs/ARNs that can assume the role"
  default     = []
}

variable "assume_role_custom" {
  type        = string
  description = "A JSON formatted string that contains the assume role policy. If set, overrides assume_role_services and assume_role_arns"
  default     = null
}

variable "external_attachment_arns" {
  type        = list(string)
  description = "List of pre-existing IAM Policy ARNs to attach to the role"
  default     = []
}

variable "policies" {
  type        = map(string)
  description = "Map of policy names to policy JSON strings"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
