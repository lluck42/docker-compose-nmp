# 基础的 docker php-fpm mysql nginx 服务器环境
docker compose for mysql php-fpm nginx

基础的 php mysql nginx 环境，其中
mysql php 分别用 docker 默认配置

nginx 只挂载出了 conf.d

使用：

$ docker-compose up

tips: 

php7.2 是个坑，新手误入

php 扩展安装

FROM php:7.1-fpm  

#切换apt软件软
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" >/etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list
#安装环境

RUN apt-get update && apt-get install -y libzip-dev
#pecl 安装扩展

RUN pecl install -o -f zip \
    && docker-php-ext-enable zip

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

#docker命令安装扩展

RUN docker-php-ext-install pdo_mysql

RUN docker-php-ext-install pdo_mysql  

RUN docker-php-ext-install mysqli  
