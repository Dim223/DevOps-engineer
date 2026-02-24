# Работа с Playbook
## 1 Основная часть
1. Подготовьте свой inventory-файл prod.yml.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает vector. 
3. Конфигурация vector должна деплоиться через template файл jinja2. От вас не требуется использовать все возможности шаблонизатора, просто вставьте стандартный конфиг в template файл. Информация по шаблонам по ссылке. не забудьте сделать handler на перезапуск vector в случае изменения конфигурации!
4. При создании tasks рекомендую использовать модули: get_url, template, unarchive, file.
Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите ansible-lint site.yml и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом --check.
7. Запустите playbook на prod.yml окружении с флагом --diff. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом --diff и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по ссылке. Так же приложите скриншоты выполнения заданий №5-8
10. Готовый playbook выложите в свой репозиторий, поставьте тег 08-ansible-02-playbook на фиксирующий коммит, в ответ предоставьте ссылку на него.

## 2 Решение 
![3-2-5-1](images/3-2-5-1.png)

![3-2-5-2](images/3-2-5-2.png)

![3-2-6-1](images/3-2-6-1.png)

![3-2-7-1](images/3-2-7-1.png)

![3-2-8-1](images/3-2-8-1.png)

## 2 Описание плейбука
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

### Переменные
clickhouse_version: Версия ClickHouse для установки</br>
clickhouse_packages: Список пакетов ClickHouse для установки</br>
vector_version: Версия Vector для установки.</br>
vector_config_path: Путь для конфигурационного файла Vector</br>
