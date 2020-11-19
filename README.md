# samba docker

下载samba镜像

	docker pull dperson/samba

修改共享目录权限

	chmod 777 /opt/data

挂载宿主机共享目录/opt/data到容器/mount
容器将/mount通过samba共享shared(镜像默认用户名和密码是bl)

	docker run -it --name samba -p 139:139 -p 445:445 -v /opt/data:/mount -d dperson/samba -u "bl;bl" -s "shared;/mount/;yes;no;no;all;none"


使用pdbedit查看容器里samba用户(默认用户和密码bl)

	docker exec samba pdbedit -L
