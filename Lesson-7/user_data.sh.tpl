#!/bin/bash
yum -y update
yum -y install httpd

TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

myip=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/local-ipv4)

cat <<HTML > /var/www/html/index.html
<html>
<h2>Build by Power of Terraform</h2>
Owner ${f_name} ${l_name} <br>

<p>Server IP: $${myip}</p>

%{ for x in names }
Hello to ${x} from ${f_name}<br>
%{ endfor }

</html>
HTML

systemctl enable httpd
systemctl start httpd
