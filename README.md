# samba docker

## 手动制作samba镜像

下载基础镜像

	docker pull centos:centos7

后台运行容器

	docker run -d --network host -it -v /home/anonymous/share2docker/:/mnt --name mysamba centos:centos7

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
