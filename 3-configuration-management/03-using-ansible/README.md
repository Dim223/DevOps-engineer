# Использование Ansible
##  Основная часть
1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.
2. При создании tasks рекомендую использовать модули: get_url, template, yum, apt.
3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.
4. Подготовьте свой inventory-файл prod.yml.
5. Запустите ansible-lint site.yml и исправьте ошибки, если они есть.
Попробуйте запустить playbook на этом окружении с флагом --check.
6. Запустите playbook на prod.yml окружении с флагом --diff. Убедитесь, что изменения на системе произведены.
7. Повторно запустите playbook с флагом --diff и убедитесь, что playbook идемпотентен.
8. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
9. Готовый playbook выложите в свой репозиторий, поставьте тег 08-ansible-03-yandex на фиксирующий коммит, в ответ предоставьте ссылку на него.
## Решение
Этот плейбук выполняет установку и настройку ClickHouse и Vector на соответствующих хостах, скачивает необходимые пакеты, устанавливает их, настраивает конфигурационные файлы и управляет службами.

### Установка и настройка ClickHouse
#### Параметры
hosts: clickhouse</br>
become: true</br>

#### Хэндлеры
Start clickhouse service</br>
Перезапускает службу ClickHouse</br>
Теги: clickhouse, start service</br>

#### Задачи
* Get clickhouse distrib</br>
  Скачивает дистрибутивы ClickHouse для архитектуры AMD64</br>
  Теги: clickhouse, distr</br>

* Update apt cache</br>
Обновляет кэш APT</br>

* *nstall clickhouse packages using dpkg</br>
Устанавливает пакеты ClickHouse с использованием dpkg</br>
Теги: clickhouse, install</br>
Notify: Start clickhouse service</br>

* Flush handlers</br>
Выполняет все отложенные хэндлеры</br>
Теги: clickhouse, start service</br>

* Wait for clickhouse-server to be ready</br>
Ожидает, пока сервер ClickHouse станет доступен на порту 9000</br>
Теги: clickhouse, wait</br>

* Create database</br>
Создает базу данных logs в ClickHouse</br>
Теги: clickhouse, db</br>

### Установка и настройка Vector
#### Параметры
hosts: vector</br>
become: true</br>

#### Хэндлеры
Start vector service</br>
Перезапускает службу Vector</br>
Теги: vector, restartservice</br>

#### Задачи
* Get vector distrib</br>
Скачивает дистрибутив Vector для архитектуры AMD64</br>
Теги: vector, distr</br>

* Update apt cache</br>
Обновляет кэш APT</br>

* Install vector</br>
Устанавливает пакет Vector с использованием dpkg</br>
Теги: vector, install</br>

* Deploy vector configuration</br>
Развертывает конфигурационный файл Vector с использованием шаблона Jinja2</br>
Теги: vector, config</br>
Notify: Start vector service</br>

* Flush handlers</br>
Выполняет все отложенные хэндлеры</br>
Теги: vector, restart service</br>

### Установка и настройка Lighthouse
#### Параметры
hosts: lighthouse</br>
become: true</br>

#### Хэндлеры
Restart Nginx</br>
Перезапускает службу Nginx</br>
Теги: restart service, nginx</br>

#### Задачи
* Update apt cache</br>
Обновляет кэш APT</br>
Теги: update</br>

* Install Nginx</br>
Устанавливает пакет Nginx</br>
Теги: install, nginx</br>

* Start Nginx service</br>
Запускает службу Nginx</br>
Теги: service, nginx</br>

* Deploy Nginx configuration</br>
Развертывает конфигурационный файл Nginx с использованием шаблона Jinja2</br>
Теги: config, nginx</br>
Notify: Restart Nginx</br>

* Install git</br>
Устанавливает пакет Git</br>
Теги: install, git</br>

* Clone Lighthouse repository</br>
Клонирует репозиторий Lighthouse</br>
Теги: git, clone</br>

* Deploy Lighthouse configuration</br>
Развертывает конфигурационный файл Lighthouse с использованием шаблона Jinja2</br>
Теги: config, nginx</br>
Notify: Restart Nginx</br>



### Переменные
clickhouse_version:     Версия ClickHouse для установки</br>
clickhouse_packages:    Список пакетов ClickHouse для установки</br>
vector_version:         Версия Vector для установки.</br>
vector_config_path:     Путь для конфигурационного файла Vector</br>
lighthouse_repo:        URL репозитория Lighthouse</br>
lighthouse_path:        путь для клонирования репозитория Lighthouse</br>
lighthouse_host:        хост для Lighthouse</br>
lighthouse_port:        порт для Lighthouse</br>
