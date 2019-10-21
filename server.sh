sudo apt update && sudo apt upgrade -y



info "Install Oracle JDK"
# Java install
sudo apt install unzip
sudo apt install zip
# Java install sdkman
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version
sdk install java

 
info "Add PHp 7.3 repository"
sudo add-apt-repository ppa:ondrej/php -y
 

info "Add ElasticSearch sources"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

sudo sh -c 'echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" > /etc/apt/sources.list.d/elastic-7.x.list'

info "Update OS software"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt autoremove

info "Install additional software"
sudo apt-get install -y  php7.3-curl php7.3-cli php7.3-intl php7.3-mysqlnd php7.3-gd php7.3-fpm php7.3-mbstring php7.3-xml php7.3-zip elasticsearch nodejs composer redis-server mysql-server

info "Main packages"

info "Install elasticsearch"
sudo apt-get install elasticsearch
info "Install nodejs"
sudo apt-get install nodejs
info "Install composer"
sudo apt-get install composer
info "Install Redis"
sudo apt-get install redis-server
info "Install mysql"
sudo apt-get install mysql-server

 

info "Install ElasticSearch"
#apt-get install -y elasticsearch
sudo sed -i 's/-Xms1g/-Xms256m/' /etc/elasticsearch/jvm.options
sudo sed -i 's/-Xmx1g/-Xmx256m/' /etc/elasticsearch/jvm.options

sudo sed -i 's/-Xms1g/-Xms512m/' /etc/elasticsearch/jvm.options
sudo sed -i 's/-Xmx1g/-Xmx512m/' /etc/elasticsearch/jvm.options



 

 
# # //if error  mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
# systemctl stop mariadb
# rm -R /var/lib/mysql/*
# mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
# systemctl start mariadb

info "Configure MySQL"

sudo mysql_secure_installation
sudo mysql
SET GLOBAL validate_password_special_char_count = 0;
UNINSTALL PLUGIN validate_password;

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'zxc';
FLUSH PRIVILEGES;
info "Initailize databases for MySQL"
mysql -u root -p
CREATE USER 'bson'@'localhost' IDENTIFIED BY 'zxc';
GRANT ALL PRIVILEGES ON *.* TO 'bson'@'localhost' WITH GRANT OPTION;
CREATE DATABASE bson;
CREATE DATABASE bson_test;
mysql -uroot <<< "CREATE DATABASE bson"
mysql -uroot <<< "CREATE DATABASE bson_test"

exit;
 
info "Add swap space"
free -m
sudo mkdir -p /var/_swap_
cd /var/_swap_
#Here, 1M * 2000 ~= 2GB of swap memory
sudo dd if=/dev/zero of=swapfile bs=1M count=2000
sudo mkswap swapfile
chmod 600 swapfile
sudo swapon swapfile

echo "/var/_swap_/swapfile none swap sw 0 0" >> /etc/fstab
#cat /proc/meminfo
free -m
 
 
info "Add user"
sudo adduser b
sudo usermod -aG sudo b
sudo passwd b
sudo nano /etc/ssh/sshd_config

To edit the file, type i (for insert). Then, comment out the PasswordAuthentication no, and uncomment the PasswordAuthentication yes. Your file changes should now look like this:

# To disable tunneled clear text passwords, change to no here!
PasswordAuthentication yes
#PermitEmptyPasswords no
#PasswordAuthentication no

# To disable tunneled clear text passwords, change to no here!
PasswordAuthentication yes
#PasswordAuthentication no
#PermitEmptyPasswords no


geoIp
cd /usr/local/src/
sudo wget https://github.com/leev/ngx_http_geoip2_module/archive/3.0.tar.gz
sudo tar -xzvf 3.0.tar.gz
sudo rm -rf 3.0.tar.gz
gunzip GeoLite2-City.tar.gz
#MaxmindDB

# installl nginx 
sudo add-apt-repository -y ppa:maxmind/ppa
sudo apt update && sudo apt upgrade -y 

sudo apt install -y perl libperl-dev libgd3 libgd-dev libgeoip1 libgeoip-dev geoip-bin libxml2 libxml2-dev libxslt1.1 libxslt1-dev

sudo apt-get install libpcre3 libpcre3-dev libssl-dev


sudo add-apt-repository -y ppa:maxmind/ppa
sudo apt-get update
sudo apt-get install -y libmaxminddb-dev
 


cd /tmp
wget https://nginx.org/download/nginx-1.17.0.tar.gz
tar -zxvf nginx-1.17.0.tar.gz
ls -l
cd nginx-1.17.0
./configure --help
./configure --help | grep 'http_v2'

./configure --with-http_v2_module --with-http_ssl_module    --with-http_mp4_module  --with-http_geoip_module --with-pcre 
 
./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --user=nginx --group=nginx \
              --with-select_module \
              --with-poll_module \
              --with-threads \
              --with-file-aio \
              --with-http_ssl_module \
              --with-http_v2_module \
              --with-http_realip_module \
              --with-http_addition_module \
              --with-http_xslt_module=dynamic \
              --with-http_image_filter_module=dynamic \
              --with-http_geoip_module=dynamic \
              --with-http_sub_module \
              --with-http_dav_module \
              --with-http_flv_module \
              --with-http_mp4_module \
              --with-http_gunzip_module \
              --with-http_gzip_static_module \
              --with-http_auth_request_module \
              --with-http_random_index_module \
              --with-http_secure_link_module \
              --with-http_degradation_module \
              --with-http_slice_module \
              --with-http_stub_status_module \
              --with-http_perl_module=dynamic \
              --with-perl_modules_path=/usr/share/perl/5.26.1 \
              --with-perl=/usr/bin/perl \
              --http-log-path=/var/log/nginx/access.log \
              --http-client-body-temp-path=/var/cache/nginx/client_temp \
              --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
              --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
              --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
              --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
              --with-mail=dynamic \
              --with-mail_ssl_module \
              --with-stream=dynamic \
              --with-stream_ssl_module \
              --with-stream_realip_module \
              --with-stream_geoip_module=dynamic \
              --with-stream_ssl_preread_module \
              --with-compat \
              --with-pcre  \
              --with-pcre-jit \
              --with-debug --add-dynamic-module=/usr/local/src/ngx_http_geoip2_module-3.0



make
sudo make install

Create NGINX system group and user:
# useradd --no-create-home nginx for Arch

sudo adduser --system --home /nonexistent --shell /bin/false --no-create-home --disabled-login --disabled-password --gecos "nginx user" --group nginx

sudo nginx -t
# Will throw this error -> nginx: [emerg] mkdir() "/var/cache/nginx/client_temp" failed (2: No such file or directory)

# Create NGINX cache directories and set proper permissions
sudo mkdir -p /var/cache/nginx/client_temp /var/cache/nginx/fastcgi_temp /var/cache/nginx/proxy_temp /var/cache/nginx/scgi_temp /var/cache/nginx/uwsgi_temp
sudo chmod 700 /var/cache/nginx/*
sudo chown nginx:root /var/cache/nginx/*

# Re-check syntax and potential errors.
sudo nginx -t


sudo ln -s /usr/lib/nginx/modules /etc/nginx/modules

sudo nano /etc/systemd/system/nginx.service

[Unit]
Description=nginx - high performance web server
Documentation=https://nginx.org/en/docs/
After=network-online.target remote-fs.target nss-lookup.target
Wants=network-online.target

[Service]
Type=forking
PIDFile=/var/run/nginx.pid
ExecStartPre=/usr/sbin/nginx -t -c /etc/nginx/nginx.conf
ExecStart=/usr/sbin/nginx -c /etc/nginx/nginx.conf
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s TERM $MAINPID

[Install]
WantedBy=multi-user.target


sudo systemctl enable nginx.service
sudo systemctl start nginx.service
sudo systemctl is-enabled nginx.service
# enabled
sudo nano /etc/ufw/applications.d/nginx

[Nginx HTTP]
title=Web Server (Nginx, HTTP)
description=Small, but very powerful and efficient web server
ports=80/tcp

[Nginx HTTPS]
title=Web Server (Nginx, HTTPS)
description=Small, but very powerful and efficient web server
ports=443/tcp

[Nginx Full]
title=Web Server (Nginx, HTTP + HTTPS)
description=Small, but very powerful and efficient web server
ports=80,443/tcp


sudo ufw app list

sudo rm /etc/nginx/*.default

sudo mkdir /etc/nginx/{conf.d,snippets,sites-available,sites-enabled}
sudo chmod 640 /var/log/nginx/*
sudo chown nginx:adm /var/log/nginx/access.log /var/log/nginx/error.log

sudo nano /etc/logrotate.d/nginx

/var/log/nginx/*.log {
    daily
    missingok
    rotate 52
    compress
    delaycompress
    notifempty
    create 640 nginx adm
    sharedscripts
    postrotate
            if [ -f /var/run/nginx.pid ]; then
                    kill -USR1 `cat /var/run/nginx.pid`
            fi
    endscript
}

if error connect() to unix:/var/run/php-fpm/php-fpm.sock failed (13: Permission denied)
# sudo usermod -a -G http nginx
# sudo systemctl restart nginx.service 
# sudo systemctl restart php-fpm.service

sertbot

sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot

sudo apt-get install certbot python-certbot-nginx 

certbot --help

sudo certbot --nginx

sudo certbot renew --dry-run

crontab -e
@daily sudo certbot renew

crontab -l



server {
   charset utf-8;
   client_max_body_size 128M;
   sendfile off;

   listen 80; ## listen for ipv4
   #listen [::]:80 default_server ipv6only=on; ## listen for ipv6

   server_name bakay.info;
   root        /app/bakay.info/public/;
   index       index.php;

   #  access_log  /app/log/frontend-access.log;
   error_log   /app/log/bakay.info/bakay.info-error.log;

   location / {
       # Redirect everything that isn't a real file to index.php
       try_files $uri $uri/ /index.php$is_args$args;
   }

   # uncomment to avoid processing of calls to non-existing static files by Yii
   #location ~ \.(js|css|png|jpg|gif|swf|ico|pdf|mov|fla|zip|rar)$ {
   #    try_files $uri =404;
   #}
   #error_page 404 /404.html;

   location ~ \.php$ {
       include fastcgi_params;
       fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
       #fastcgi_pass   127.0.0.1:9000;
       fastcgi_pass unix:/var/run/php/php7.1-fpm.sock;
       try_files $uri =404;
   }

   location ~ /\.(ht|svn|git) {
       deny all;
   }
}



If like me, you are using some micro VM lacking of memory, creating a swap file does the trick:

free -m
mkdir -p /var/_swap_
cd /var/_swap_
#Here, 1M * 2000 ~= 2GB of swap memory
dd if=/dev/zero of=swapfile bs=1M count=1000
mkswap swapfile
swapon swapfile
chmod 600 swapfile
echo "/var/_swap_/swapfile none swap sw 0 0" >> /etc/fstab
#cat /proc/meminfo
free -m
btw, feel free to select another location/filename/size for the file.
/var is probably not the best place, but I don't know which place would be, and rarely care since tiny servers are mostly used for testing purposes.