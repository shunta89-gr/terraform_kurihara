variable "source_dir" {
    type = string
}

variable "output_path" {
    type = string
}

variable "bucket_name" {
    type = string
}

variable "bucket_region" {
    type = string
}

variable "function_region" {
    type = string
}

variable "function_name" {
    type = string
}

variable "function_description" {
    type    = string
    default = ""
}

variable "function_runtime" {
    type = string
}

variable "entry_point" {
    type = string
}

variable "function_memory" {
    type    = string
    default = "256M"
}

variable "timeout_seconds" {
    type = number
}

variable "max_instance_count" {
    type    = number
    default = 1
}