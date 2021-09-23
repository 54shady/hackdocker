# samba docker

## 基础使用

下载基础image

	docker pull centos:centos7

查看系统中的image

	docker images

交互式运行image,运行起来后就叫container

	docker run -it --name myctos centos:centos7

查看当前container情况

	docker ps -l

删除container

	docker rm myctos

后台运行container

	docker run -d -it --name myctos centos:centos7

查看某个container后进入执行

	docker ps -l
	docker exec -it myctos bash
	docker exec -it myctos sh # 有些容器中没有bash

后台运行容器(并挂在本地目录share2docker到container中的mnt下)

	docker run -d --network host -it -v /home/anonymous/share2docker/:/mnt --name mysamba centos:centos7

开启全部container

	docker start $(docker ps -q)

停止全部container

	docker stop $(docker ps -q)

删除全部container

	docker rm $(docker ps -aq)

## 制作samba服务docker镜像

执行相应操作

	docker exec mysamba sed -i 's/keepcache=0/keepcache=1/' /etc/yum.conf
	docker exec mysamba yum update -y
	docker exec mysamba yum install -y python3 samba

将容器改动提交成镜像

	docker commit -m 'samba,python3' mysamba samba:v1

将镜像保存到本地

	docker save -o sambaimage.tar samba:v1

删除当前已经存在的镜像

	docker rmi -f samba:v1

使用时将本地镜像导出即可

	docker load < sambaimage.tar

通过制作的镜像启动容器

	docker run -d -it --name sambademo -p 139:139 -p 445:445 samba:v1

进入容器添加用户

	docker exec -it sambademo bash
	# smbpasswd -a root

使用pdbedit查看容器里samba用户

	docker exec samba pdbedit -L

启动samba服务

	docker exec sambademo smbd
	docker exec sambademo nmbd

## web server

下载nginx的docker镜像

	docker pull nginx

创建对应的容器,映射本地端口999到container里的80端口(path-to-html下时html的网页文件)

	docker run -d --name web -p 999:80 -v /path-to-html-dir:/usr/share/nginx/html nginx

在浏览器中访问ip:999即可

## prometheus and grafana

	docker run -d --name myprometheus -p 9090:9090 -v /path-cotain-prometheus.yml:/etc/prometheus prom/prometheus:v2.30.0
	docker run -d --name mygrafana -p 3000:3000 --name gfn grafana/grafana
