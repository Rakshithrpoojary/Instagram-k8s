variable "aws-cred" {
  type = object({
    access-key = string
    secret-key = string
    region     = string
  })
}
variable "aws-vpc" {
  type = object({
    cidr = string
    tags = map(string)
  })

}

variable "subnet" {
  type = object({
    cidr              = string,
    availability_zone = string,
    tags              = map(string)
  })

}

variable "sg" {
  type = map(object({
    port = list(number)
  }))
}
variable "instance" {
  type = map(object({
    ami         = string,
    type        = string,
    storagetype = string,
    storage     = number,
    sg          = string,
    tags        = map(string)
  }))
}
