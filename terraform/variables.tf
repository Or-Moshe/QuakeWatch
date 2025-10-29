
##################### ec2 ###########################
variable "instance_type" {
  type        = string
  description = "The EC2 instance type"
  default     = "t2.micro"
}

variable "instance_tag" {
  type        = string
  description = "instance tag name"
  default     = "quakewatch-server"
}

##################### security-group ###########################
variable "security_group_name" {
  type        = string
  description = "The security group name"
  default     = "quakewatch-sg"
}
variable "security_group_description" {
  type        = string
  description = "The security group description"
  default     = "Allow SSH, HTTP, HTTPS"
}

  variable "security_group_ingress_SSH_from_port" {
  type        = number
  description = "The security group ingress ssh from port"
  default     = 22
}
variable "security_group_ingress_SSH_to_port" {
  type        = number
  description = "The security group ingress ssh to port"
  default     = 22
}

variable "security_group_ingress_HTTP_from_port" {
  type        = number
  description = "The security group ingress http from port"
  default     = 80
}
variable "security_group_ingress_HTTP_to_port" {
  type        = number
  description = "The security group ingress http to port"
  default     = 80
}
variable "security_group_ingress_HTTPS_from_port" {
  type        = number
  description = "The security group ingress https from port"
  default     = 443
}
variable "security_group_ingress_HTTPS_to_port" {
  type        = number
  description = "The security group ingress https to port"
  default     = 443
}

variable "security_group_allowed_ssh_cidr" {
  type        = list(string)
  description = "CIDR block allowed to SSH"
  default     = ["0.0.0.0/0"]
}
variable "security_group_allowed_http_cidr" {
  type        = list(string)
  description = "CIDR block allowed to http"
  default     = ["0.0.0.0/0"]
}
variable "security_group_allowed_https_cidr" {
  type        = list(string)
  description = "CIDR block allowed to https"
  default     = ["0.0.0.0/0"]
}


