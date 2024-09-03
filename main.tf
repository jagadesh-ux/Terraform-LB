provider "aws" { 
 region = "ap-southeast-2" 
} 
resource "aws_key_pair" "test" { 
 key_name = var.key_name 
 public_key = file("./demo.pub") 
} 
resource "aws_instance" "web" { 
 ami = var.ami 
 instance_type = var.instance_type 
 subnet_id = var.subnet_id[0]
 key_name = aws_key_pair.test.key_name 
 vpc_security_group_ids =[var.vpc_security_group_id]
 tags = { 
 Name = var.tag[0] 
 } 
 connection {
 type = "ssh" 
 user = "ubuntu" 
 private_key = file("./demo")  
 host = self.public_ip 
 timeout = "1m" 
 agent = false 
 } 
 provisioner "remote-exec" { 
 inline = [ 
  "sudo apt-get update", 
 "sudo apt-get install nginx -y",
 "touch index.nginx-debian.html",
 "echo '<h1> This is my nginx appalication </h1>' | tee index.nginx-debian.html",
 "sudo mv index.nginx-debian.html /var/www/html/index.nginx-debian.html",
 "sudo systemctl restart nginx.service"
 ] 
 } 
} 
resource "aws_instance" "webserver" { 
 ami = var.ami
 instance_type = var.instance_type
 subnet_id = var.subnet_id[1]
 key_name = aws_key_pair.test.key_name 
 vpc_security_group_ids =["sg-0bc5cd5487adfa7bd"]
 tags = { 
 Name = var.tag[1]
 } 
 connection {
 type = "ssh" 

 user = "ubuntu" 
 private_key = file("./demo")  
 host = self.public_ip 
 timeout = "1m" 
 agent = false 
 } 
 provisioner "remote-exec" { 
 inline = [ 
 "sudo apt-get update", 
 "sudo apt-get install nginx -y",
 "touch index.nginx-debian.html",
 "echo '<h1> This is my nginx appalication 1 </h1>' | tee index.nginx-debian.html",
 "sudo mv index.nginx-debian.html /var/www/html/index.nginx-debian.html",
 "sudo systemctl restart nginx.service"
 ] 
 } 
} 
