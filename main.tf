provider "aws" { 
 region = "us-west-2" 
} 
resource "aws_key_pair" "test" { 
 key_name = var.key_name 
 public_key = file("C:/Users/91879/ashu/siva/demo.pub") 
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
 private_key = file("C:/Users/91879/ashu/siva/demo")  
 host = self.public_ip 
 timeout = "1m" 
 agent = false 
 } 
 provisioner "remote-exec" { 
 inline = [ 
  "sudo add-apt-repository ppa:tomcat9",
 "sudo apt-get update", 
 "sudo apt-get install maven -y",
 "sudo apt-get install tomcat9 tomcat9-admin -y",
 "mkdir siva && cd siva",
 "git clone https://github.com/gampasivakumar4422/Task-1.git",
 "cd Task-1 && mvn clean package",
 "cd target && sudo mv SivaKumar-1.0.war /var/lib/tomcat9/webapps/Siva.war"
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
 private_key = file("C:/Users/91879/ashu/siva/demo")  
 host = self.public_ip 
 timeout = "1m" 
 agent = false 
 } 
 provisioner "remote-exec" { 
 inline = [ 
  "sudo add-apt-repository ppa:tomcat9",
 "sudo apt-get update", 
 "sudo apt-get install maven -y",
 "sudo apt-get install tomcat9 tomcat9-admin -y",
 "mkdir siva && cd siva",
 "git clone https://github.com/gampasivakumar4422/Task-2.git",
 "cd Task-1 && mvn clean package",
 "cd target && sudo mv SivaKumar-1.0.war /var/lib/tomcat9/webapps/Siva.war"
 ] 
 } 
} 
