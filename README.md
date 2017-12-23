# 基础的 docker php-fpm mysql nginx 服务器环境
docker compose for mysql php-fpm nginx

基础的 php mysql nginx 环境，其中
mysql php 分别用 docker 默认配置

nginx 只挂载出了 conf.d

使用：

$ docker-compose up;

关键点：

1> 127.0.0.1 要换成 docker inspect "容器id" | grep "IP" 中的ip地址

2> nginx 挂载全部 配置无法启动

3> 如何自己不懂得话，一定要找一个好一点你的 site.conf

4> nginx --link php --link mysql

如果自己的不能用的话，这些是关键点

tips: php7.2 是个坑，新手误入
