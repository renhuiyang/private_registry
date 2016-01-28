#!/bin/bash
yum update -y

yum install httpd-tools -y

curl -sSL https://get.docker.com/ | sh

service docker start

mkdir -p  /opt/docker/registry/conf

htpasswd -cb /opt/docker/registry/conf/docker-registry.htpasswd test 123456

touch /opt/docker/registry/conf/error.log

openssl req -subj "/C=CN/ST=BeiJing/L=Dongcheng/CN=registry.test" -x509 -nodes -newkey rsa:2048 -keyout /opt/docker/registry/conf/docker-registry.key -out /opt/docker/registry/conf/docker-registry.crt

docker run -d -v /opt/docker/registry/data:/tmp/registry-dev --name registryv2 registry:2.0.1

docker run -d -v /opt/docker/registry/data:/tmp/registry-dev --name registryv1 registry:0.9.1

docker run -d -p 443:443 --link registryv1:registryv1 --link registryv2:registryv2 -v /opt/docker/registry/conf/docker-registry.htpasswd:/etc/nginx/.htpasswd:ro -v /opt/docker/registry/conf:/etc/nginx/ssl:ro -v /opt/docker/registry/conf/error.log:/var/log/nginx/error.log --name docker-registry-proxy-yrh renhuiyang/nginx_dockerregistry
