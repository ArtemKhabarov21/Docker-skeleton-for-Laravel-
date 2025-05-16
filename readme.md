# Laravel Docker Environment

## Структура проекта
```
.
├── docker-compose.yml
├── Dockerfile
├── DOCKER_COMMANDS.md
├── nginx/
│   └── laravel.conf
└── laravel-app/          # Ваш Laravel проект здесь
    ├── app/
    ├── public/
    ├── vendor/
    ├── composer.json
    └── ...
```

## Быстрый старт

1. **Клонируйте или создайте Laravel проект в папке `laravel-app/`**:
   ```bash
   # Создание нового проекта
   composer create-project laravel/laravel laravel-app
   
   # Или клонирование существующего
   git clone <your-repo> laravel-app
   ```

2. **Запустите Docker контейнеры**:
   ```bash
   docker-compose up -d
   ```

3. **Настройте Laravel (если нужно)**:
   ```bash
   # Вход в контейнер
   docker exec -it laravel-app bash
   
   # Установка зависимостей
   composer install
   npm install
   
   # Копирование .env и генерация ключа
   cp .env.example .env
   php artisan key:generate
   
   # Настройка прав
   chmod -R 775 storage bootstrap/cache
   ```

4. **Доступ к приложению**: http://localhost:8010

## Настройки подключения к БД

В файле `.env` вашего Laravel проекта укажите:
```env
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=laravel_user
DB_PASSWORD=secret_laravel
```

## Включенные сервисы

- **PHP 8.2-FPM** с Composer, NPM, и 1Password CLI
- **Nginx** веб-сервер
- **MySQL 8.0** база данных

## Порты

- **8010** - Nginx (ваше приложение)
- **3308** - MySQL

Подробные команды смотрите в [DOCKER_COMMANDS.md](DOCKER_COMMANDS.md).