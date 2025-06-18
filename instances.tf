# INSTANCES
resource "aws_instance" "nginx1" {
  ami           = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
  instance_type = var.instance_type

  cpu_options {
    core_count       = var.core_count
    threads_per_core = var.thread_count
  }

  subnet_id       = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.public_security_group.id]

  iam_instance_profile = aws_iam_instance_profile.nginx_profile.name

  #user_data = file("./initial-server-setup.sh") #TODO: To fix this later stage

  user_data = <<-EOF
    #! /bin/bash
    sudo amazon-linux-extras install -y nginx1
    sudo service nginx start

    #aws s3 cp -r s3://S{aws_s3_bucket.web_bucket.id//webcontent/ /home/ec2-user/ 
    #aws s3 sync s3://$(aws_s3_bucket.web_bucket.id//webcontent/ /home/ec2-user/


    aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/webcontent/index.html /home/ec2-user/index.html
    aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/webcontent/styles.css /home/ec2-user/styles.css 
    aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/webcontent/campus.jpg /home/ec2-user/campus.jpg 
    aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/webcontent/students.jpg /home/ec2-user/students.jpg 
    aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/webcontent/programs.jpg /home/ec2-user/programs.jpg

    sudo rm /usr/share/nginx/html/index.html

    sudo cp /home/ec2-user/index.html /usr/share/nginx/html/index.html
    sudo cp /home/ec2-user/styles.css /usr/share/nginx/html/styles.css 
    sudo cp /home/ec2-user/campus.jpg /usr/share/nginx/html/campus.jpg 
    sudo cp /home/ec2-user/students.jpg /usr/share/nginx/html/students.jpg 
    sudo cp /home/ec2-user/programs.jpg /usr/share/nginx/html/programs.jpg
  EOF

  tags = {
    "Name" : "nginx1"
  }
}

resource "aws_instance" "nginx2" {
  ami           = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
  instance_type = "t3.micro"

  cpu_options {
    core_count       = var.core_count
    threads_per_core = var.thread_count
  }

  subnet_id       = aws_subnet.public_subnet_2.id
  security_groups = [aws_security_group.public_security_group.id]

  iam_instance_profile = aws_iam_instance_profile.nginx_profile.name

  #user_data = file("./initial-server-setup.sh") #TODO: To fix this later stage

  user_data = <<-EOF
    #! /bin/bash
    sudo amazon-linux-extras install -y nginx1
    sudo service nginx start

    #aws s3 cp -r s3://S{aws_s3_bucket.web_bucket.id//webcontent/ /home/ec2-user/ 
    #aws s3 sync s3://$(aws_s3_bucket.web_bucket.id//webcontent/ /home/ec2-user/


    aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/webcontent/index.html /home/ec2-user/index.html
    aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/webcontent/style.css /home/ec2-user/styles.css 
    aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/webcontent/campus.jpg /home/ec2-user/campus.jpg 
    aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/webcontent/students.jpg /home/ec2-user/students.jpg 
    aws s3 cp s3://${aws_s3_bucket.web_bucket.id}/webcontent/programs.jpg /home/ec2-user/programs.jpg

    sudo rm /usr/share/nginx/html/index.html

    sudo cp /home/ec2-user/index.html /usr/share/nginx/html/index.html
    sudo cp /home/ec2-user/styles.css /usr/share/nginx/html/styles.css 
    sudo cp /home/ec2-user/campus.jpg /usr/share/nginx/html/campus.jpg 
    sudo cp /home/ec2-user/students.jpg /usr/share/nginx/html/students.jpg 
    sudo cp /home/ec2-user/programs.jpg /usr/share/nginx/html/programs.jpg
  EOF

  tags = {
    "Name" : "nginx2"
  }
}

resource "aws_iam_instance_profile" "nginx_profile" {
  name = "nginx-profile"
  role = "LabRole"
}