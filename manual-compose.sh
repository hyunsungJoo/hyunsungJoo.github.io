#!/bin/bash

# var
BLOG_1="hyunsungjoo-blog-a.internal"
BLOG_2="hyunsungjoo-blog-b.internal"
BLOG_1_IMG_NAME="blog-1-img"
BLOG_2_IMG_NAME="blog-2-img"

# rm & rmi
figlet remove all
sudo docker stop $(sudo docker ps -q)
sudo docker rm $(sudo docker ps -a -q)
sudo docker rmi $(sudo docker images -q)

sudo docker network rm blog

# build
figlet build
sudo docker build -t blog-a -f server-a/Dockerfile server-a
sudo docker build -t blog-b -f server-b/Dockerfile server-b
sudo docker build -t blog-lb -f server-lb/Dockerfile server-lb

#run
sudo docker run -itd --name blog-a-1 -p 8001:80 blog-a
sudo docker run -itd --name blog-b-1 -p 8002:80 blog-b
sudo docker run -itd --name blog-lb-1 -p 8003:80 blog-lb

# docker network
sudo docker network create blog
sudo docker network connect blog blog-a-1
sudo docker network connect blog blog-b-1
sudo docker network connect blog blog-lb-1


figlet ps
sudo docker ps

# end
sl -aF
