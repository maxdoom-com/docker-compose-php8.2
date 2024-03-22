FROM alpine:3.19

RUN apk add                     \
    bash                        \
    mc                          \
    git                         \
    apache2                     \
    apache2-ssl                 \
    apache2-proxy               \
    apache2-proxy-html          \
    mysql-client                \
    graphicsmagick              \
    php82                       \
    php82-apache2               \
    php82-pdo_mysql             \
    php82-mysqli                \
    php82-mysqlnd               \
    php82-pdo_sqlite            \
    php82-session               \
    php82-gd                    \
    php82-xml                   \
    php82-simplexml             \
    php82-xmlreader             \
    php82-xmlwriter             \
    php82-zip                   \
    php82-intl                  \
    php82-fileinfo              \
    php82-iconv                 \
    php82-tokenizer             \
    php82-phar                  \
    php82-curl                  \
    php82-posix                 \
    php82-pcntl                 \
    php82-mbstring              \
    php82-gmp                   \
    php82-bcmath                \
    php82-opcache               \
    php82-pecl-apcu             \
    php82-exif                  \
    php82-soap                  \
    php82-ldap                  \
    php82-pecl-imagick          \
    python3                     \
    py3-virtualenv              #

# fix a dompdf problem...
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.13/community/ gnu-libiconv=1.15-r3
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so


COPY home/you /home/you
COPY srv/ssl /srv/ssl
COPY srv/adminer /srv/adminer
# COPY etc/apache2/conf.d/vhosts.d /etc/apache2/conf.d/vhosts.d

# RUN cd /usr/bin && ln -s php82 php

RUN ln -s /usr/lib/libxml2.so.2 /usr/lib/libxml2.so
# Syntax error on line 13 of /etc/apache2/conf.d/proxy-html.conf:
# Cannot load /usr/lib/libxml2.so into server: Error loading shared library /usr/lib/libxml2.so: No such file or directory

ADD ["sbin/boot.sh", "/sbin/"]
ENTRYPOINT ["/bin/sh", "/sbin/boot.sh"]
