FROM php:8.2-apache

# Surpresses debconf complaints of trying to install apt packages interactively
# https://github.com/moby/moby/issues/4032#issuecomment-192327844

ARG DEBIAN_FRONTEND=noninteractive

# Update
RUN apt-get -y update --fix-missing
RUN apt-get upgrade -y
RUN apt-get --no-install-recommends install -y apt-utils
RUN rm -rf /var/lib/apt/lists/*


# Install useful tools and install important libaries
RUN apt-get -y update
RUN apt-get -y --no-install-recommends install nano wget \
    dialog \
    libsqlite3-dev \
    libsqlite3-0
RUN apt-get -y --no-install-recommends install default-mysql-client \
    zlib1g-dev \
    libzip-dev \
    libicu-dev 
RUN apt-get -y --no-install-recommends install --fix-missing apt-utils \
    build-essential \
    git \
    curl \
    libonig-dev
RUN    apt-get install -y iputils-ping
RUN    apt-get -y --no-install-recommends install --fix-missing libcurl4 \
    libcurl4-openssl-dev \
    zip \
    openssl
RUN rm -rf /var/lib/apt/lists/*
RUN    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install xdebug
RUN pecl install xdebug-3.2.1
RUN docker-php-ext-enable xdebug
RUN mkdir /var/log/xdebug

# Install redis
RUN pecl install redis-5.3.7
RUN docker-php-ext-enable redis

# Install imagick
RUN apt-get update
RUN apt-get -y --no-install-recommends install --fix-missing libmagickwand-dev
RUN rm -rf /var/lib/apt/lists/*

# Workarround until imagick is available in pecl with php8 support
# Imagick Commit to install
# https://github.com/Imagick/imagick
ARG IMAGICK_COMMIT="132a11fd26675db9eb9f0e9a3e2887c161875206"

RUN pecl install imagick-3.7.0
RUN docker-php-ext-enable imagick

# Other PHP8 Extensions

RUN docker-php-ext-install pdo_mysql
# RUN docker-php-ext-install pdo_sqlite
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install curl
# RUN docker-php-ext-install tokenizer
RUN docker-php-ext-install zip
RUN docker-php-ext-install -j$(nproc) intl
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install gettext
RUN docker-php-ext-install calendar
RUN docker-php-ext-install exif


# Install Freetype 
RUN apt-get -y update
RUN apt-get --no-install-recommends install -y libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev
RUN rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd

# Insure an SSL directory exists
RUN mkdir -p /etc/apache2/ssl

# Enable SSL support
RUN a2enmod ssl && a2enmod rewrite

# Enable apache modules
RUN a2enmod rewrite headers

# Cleanup
RUN rm -rf /usr/src/*
