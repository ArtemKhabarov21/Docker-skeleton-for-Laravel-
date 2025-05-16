# Основные Docker команды для работы с Laravel проектом

## Запуск контейнеров
```bash
docker-compose up -d
```

## Проверка работающих контейнеров
```bash
docker ps
```

## Перезапуск контейнеров
```bash
docker-compose restart
```

## Остановка контейнеров
```bash
docker-compose down
```

## Удаление всех данных и перезапуск контейнеров
```bash
docker-compose down -v
docker-compose up -d
```

## Вход в контейнер приложения Laravel
```bash
docker exec -it laravel-app bash
```

## Просмотр логов контейнеров
```bash
# Все контейнеры
docker-compose logs -f

# Конкретный контейнер
docker-compose logs -f app
docker-compose logs -f webserver
docker-compose logs -f db
```

## Laravel Artisan команды

### Запуск команды Artisan внутри контейнера
```bash
docker exec -it laravel-app bash -c "php artisan <команда>"
```

### Примеры Artisan команд:
```bash
# Миграции
docker exec -it laravel-app bash -c "php artisan migrate"
docker exec -it laravel-app bash -c "php artisan migrate:fresh --seed"

# Кеш
docker exec -it laravel-app bash -c "php artisan cache:clear"
docker exec -it laravel-app bash -c "php artisan config:clear"
docker exec -it laravel-app bash -c "php artisan view:clear"

# Пользовательская команда
docker exec -it laravel-app bash -c "php artisan onepassword:check-sites"
```

## Composer команды
```bash
# Установка зависимостей
docker exec -it laravel-app bash -c "composer install"
docker exec -it laravel-app bash -c "composer update"

# Добавление пакета
docker exec -it laravel-app bash -c "composer require пакет/название"
```

## NPM команды
```bash
# Установка зависимостей
docker exec -it laravel-app bash -c "npm install"

# Сборка для разработки
docker exec -it laravel-app bash -c "npm run dev"

# Сборка для продакшна
docker exec -it laravel-app bash -c "npm run build"

# Наблюдение за изменениями
docker exec -it laravel-app bash -c "npm run watch"
```

## Работа с базой данных

### Подключение к MySQL
```bash
docker exec -it mysql-laravel mysql -u laravel_user -p laravel_db
```

### Выполнение SQL команд
```bash
docker exec -it mysql-laravel mysql -u laravel_user -p -e "SHOW DATABASES;"
```

## Создание нового Laravel проекта
```bash
# Если директория laravel-app пустая
docker exec -it laravel-app bash -c "composer create-project laravel/laravel ."

# Или клонирование существующего проекта
git clone <repo_url> laravel-app
```

## Настройка Laravel после создания/клонирования
```bash
# Копирование .env файла
docker exec -it laravel-app bash -c "cp .env.example .env"

# Генерация ключа приложения
docker exec -it laravel-app bash -c "php artisan key:generate"

# Установка прав на папки
docker exec -it laravel-app bash -c "chmod -R 775 storage bootstrap/cache"
```

## Удаление и очистка

### Удаление остановленных контейнеров, неиспользуемых образов и сетей
```bash
docker system prune -f
```

### Полная очистка Docker
```bash
docker system prune -a -f
```

### Пересборка контейнера приложения
```bash
docker-compose down
docker-compose build --no-cache app
docker-compose up -d
```

## Полезные алиасы для .bashrc/.zshrc
```bash
# Добавьте эти алиасы в ваш файл конфигурации shell
alias dcup='docker-compose up -d'
alias dcdown='docker-compose down'
alias dcrestart='docker-compose restart'
alias dcbuild='docker-compose build'
alias dcps='docker ps'
alias dclogs='docker-compose logs -f'

# Laravel специфичные алиасы
alias dart='docker exec -it laravel-app bash -c "php artisan'
alias dcomposer='docker exec -it laravel-app bash -c "composer'
alias dnpm='docker exec -it laravel-app bash -c "npm'
alias dbash='docker exec -it laravel-app bash'
```