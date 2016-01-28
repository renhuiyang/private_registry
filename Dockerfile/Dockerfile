FROM centos 

# Install Nginx.
RUN \
    yum install gc gcc gcc-c++ pcre-devel zlib-devel openssl-devel wget make -y &&\
    wget http://nginx.org/download/nginx-1.9.4.tar.gz &&\
    tar zxvf ./nginx-1.9.4.tar.gz &&\
    cd ./nginx-1.9.4 &&\
    ./configure --user=www --group=www --prefix=/opt/nginx  --with-pcre --with-http_stub_status_module --with-http_ssl_module --with-http_addition_module --with-http_realip_module --with-http_flv_module &&\
    make &&\
    make install &&\
    cd .. &&\
    rm -rf `pwd`/nginx-1.9.4/ &&\ 
    rm -rf `pwd`/nginx-1.9.4.tar.gz &&\
    groupadd www -g 58 &&\
    useradd -u 58 -g www www

COPY nginx.conf /opt/nginx/conf/nginx.conf
COPY mime.types /etc/nginx/mime.types
COPY nginx.sh nginx.sh
RUN chmod +x nginx.sh
VOLUME ["/etc/nginx/.htpasswd","/etc/nginx/ssl","/var/log/nginx/error.log"]

# Define default command.
CMD ["./nginx.sh"]

# Expose ports.
EXPOSE 443
