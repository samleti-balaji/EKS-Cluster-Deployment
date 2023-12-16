variable "dynamodb_name" {
    default = "my-dynamo-db-practice-1"
  
}
variable "hash_key" {
    default = "LockID"
    type = string
  
}

resource "aws_dynamodb_table" "our-table" {
    name = var.dynamodb_name
    read_capacity = 5
    write_capacity = 5
    hash_key = var.hash_key
    attribute {
        name = var.hash_key
        type = "S"
    }
     tags = {
        Name = "Dynamo DB for locking and unlocking"
    }
}