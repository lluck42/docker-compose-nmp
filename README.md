# 基础的 docker php-fpm mysql nginx 服务器环境
docker compose for mysql php-fpm nginx

基础的 php mysql nginx 环境，其中
mysql php 分别用 docker 默认配置

nginx 只挂载出了 conf.d

使用：

$ docker-compose up

关键点：

tips: php7.2 是个坑，新手误入
