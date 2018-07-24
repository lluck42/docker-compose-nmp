FROM php:7.0-fpm

#安装环境
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian/ jessie-backports main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie-backports main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >>/etc/apt/sources.list

#pecl 安装扩展
ENV PHPREDIS_VERSION 3.1.3
RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && mkdir -p /usr/src/php/ext/ \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \ 
    && docker-php-ext-install redis \
    && rm -rf /usr/src/php

RUN apt-get update
RUN apt-get install -y libzip-dev

#thinkPHP GD freetype 扩展
RUN apt-get install -y libjpeg-dev \
&& apt-get install -y libfreetype6-dev \
&& apt-get install -y libpng-dev

#docker命令安装扩展
RUN docker-php-ext-install zip 
RUN docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd
RUN docker-php-ext-install pdo_mysql \
&& docker-php-ext-install mysqli


#开启守护进程 守护 php artisan queue:work
RUN apt-get install -y supervisor
#RUN supervisord -c /etc/supervisor/supervisord.conf
# 开启守护进程要在容器中开启，可能和挂在顺序有关