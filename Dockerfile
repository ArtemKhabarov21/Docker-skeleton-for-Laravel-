FROM php:8.2-fpm

# Устанавливаем зависимости
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    curl \
    gnupg \
    git \
    nodejs \
    npm \
    && docker-php-ext-install zip pdo_mysql

# Устанавливаем 1Password CLI
RUN curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor -o /usr/share/keyrings/1password-archive-keyring.gpg \
    && echo 'deb [signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | tee /etc/apt/sources.list.d/1password.list \
    && apt-get update && apt-get install -y 1password-cli

# Проверяем установку 1Password CLI
RUN op --version

# Устанавливаем Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Устанавливаем Composer глобально (проверяем версию)
RUN composer --version

# Устанавливаем Node.js и npm (проверяем версии)
RUN node --version && npm --version

# Определяем рабочую директорию
WORKDIR /var/www/html

# Создаём необходимые папки и задаём права
RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Устанавливаем права для 1Password CLI и создаем необходимые папки
RUN mkdir -p /var/www/.config/op /var/www/.npm /var/www/.composer \
    && chown -R www-data:www-data /var/www/.config \
    && chown -R www-data:www-data /var/www/.npm \
    && chown -R www-data:www-data /var/www/.composer \
    && chmod 700 /var/www/.config

# Копируем и устанавливаем зависимости Laravel (если уже есть проект)
# COPY ./laravel-app/composer.json ./laravel-app/composer.lock ./
# RUN composer install --no-scripts --no-autoloader

# Копируем package.json для npm (если есть)
# COPY ./laravel-app/package*.json ./
# RUN npm install

USER www-data