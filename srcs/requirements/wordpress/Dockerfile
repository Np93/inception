FROM alpine:3.16

RUN	apk add --no-cache \
		mariadb-client		\
		# Wordpress core dependenties
		php8 php8-fpm php8-opcache php8-gd php8-curl php8-mysqli php8-json php-phar php8-mbstring php8-bcmath php8-bz2 php8-calendar php8-dom php8-exif php8-fileinfo php8-gd php8-iconv php8-intl php8-mysqli php8-openssl php8-sockets php8-sodium php8-xmlreader php8-xmlwriter php8-xsl php8-zip php8-zlib

# dependance php trouver sur "https://zeropointdevelopment.com/required-php-extensions-for-wordpress-wpquickies/"


#obligatoir sinon ne peut pas avoir lIUD de "l'utilisateur"nains
RUN	adduser -S nginx && addgroup -S nginx
#COPY conf/www.conf /etc/php7/php-fpm.d/www.conf
COPY conf/www.conf /etc/php8/php-fpm.d

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    cp wp-cli.phar /usr/bin/wp

WORKDIR /var/www/wordpress

COPY tools/configure.sh /tmp/configure.sh
CMD [ "sh", "/tmp/configure.sh" ]
