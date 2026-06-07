variable "file_name" {
  default = "test_file.txt"
}

variable "file_text" {
  default = "Hello, this is text inside the file!"
}

variable "tags" {
  default = {
    Owner       = "Farxod Muslimov"
    Environment = "dev"
  }
}
