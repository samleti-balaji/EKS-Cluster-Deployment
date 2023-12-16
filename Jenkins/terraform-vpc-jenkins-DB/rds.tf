/*

variable "db_engine" {} # These are the variables to launch RDS value for variable is in terraform.tfvars file
variable "db_engine_version" {}
variable "db_name" {}   
variable "db_username" {} 
variable "db_password" {}
variable "db_storage_type" {}
variable "db_subnet_group_name" {}

data "aws_subnets" "our-available-subnets" { # Here we are fetching subnets our account where name is OUR-Private-*
    filter { # Here we are filtering for the subnet whose tag name start with Our-Private-*
        name = "tag:Name"
        values = ["Our-Private-*"]
    }

}
resource "aws_db_subnet_group" "db-subnet" { # Here we are creating the db subnet group which is necessory to launch RDS instance
    name = var.db_subnet_group_name  # we are specifying name to the db subnet group
    subnet_ids = data.aws_subnets.our-available-subnets.ids  # we are using list of subnets that we fetched above
    #subnet_ids = ["${aws_subnet.our-private-subnet.id}", "${aws_subnet.our-private-subnet2.id}"]   # instad of fetching we can use direct list also
    tags = {
        Name = "db-subnet"  # name of the subnet_group
        }
  
}
resource "aws_db_instance" "our-db-instance" { # "aws_db_instance" api help to create new DB instance
    allocated_storage = 10 # 10 GB of allocated storage out of 100TB
    engine = var.db_engine  # which database to use for example mysql , postgressql etc
    engine_version = var.db_engine_version # which version of mysql, it must be availbal in console
    db_name = var.db_name # name of the database
    multi_az = true # whether to use multi AZ
    db_subnet_group_name = aws_db_subnet_group.db-subnet.name # name of the subnet group to use
    instance_class = "db.t2.micro" # which instance to use for launching DB instance
    username = var.db_username # username of the database
    password = var.db_password # password of the database
    skip_final_snapshot = true # whether to skip final snapshot or not
    storage_type = var.db_storage_type # which storage type to use
    vpc_security_group_ids = [aws_security_group.our-security-group.id] # which security group to use
    
    tags = {
        Name = "our-db-instance" # these are tags
        Environment = "dev"
    }
}

  
*/