variable "instance_name" {

    description = "Value of the Name tag for the EC2 instance"
    type = string
    default = "Another Instance"
  
}


variable "instance_count" {

    description = "number of instances to launch"
    type = number
    default = 1

}

variable "az" {

    description = "list of the availability zones"
    type = list(string)
    default = ["eu-west-3a" , "eu-west-3b",  "eu-west-3c"]


  
}