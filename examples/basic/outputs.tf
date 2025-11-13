output "basic_module_name" {
  description = "Module name from basic example"
  value       = module.example_basic.module_name
}

output "custom_module_name" {
  description = "Module name from custom example"
  value       = module.example_custom.module_name
}

output "custom_environment" {
  description = "Environment from custom example"
  value       = module.example_custom.environment
}

output "custom_tags" {
  description = "Tags from custom example"
  value       = module.example_custom.tags
}

output "variables_module_name" {
  description = "Module name from variables example"
  value       = module.example_variables.module_name
}