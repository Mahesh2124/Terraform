#!/bin/bash

apt-get update -y

apt-get install nginx -y

systemctl start nginx
systemctl enable nginx

echo "<h1>Hello World!</h1><p>Provisioned successfully via User Data.</p>" > /var/www/html/index.html
