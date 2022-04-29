variable "name" {
  type = string
  default = "sst"
  description = "The name of which your resources should start with."
  validation {
    condition = can(regex("^[0-9A-Za-z]+$", var.name))
    error_message = "Only a-z, A-Z and 0-9 are allowed to match Azure storage naming restrictions."
  }
}
variable "environment" {
  type = string
  default = "dev"
  description = "Sets the environment for the resources"
}
variable "region" {
  type = string
  default = "West Europe"
  description = "The Azure Region where the Resource Group should exist."
}