# Практическое задание по занятию "Практическое применение Docker"

## Задача 1
1. Сделайте в своем GitHub пространстве fork репозитория.
* https://github.com/Dim223/shvirtd-example-python#
2. Создайте файл Dockerfile.python на основе существующего Dockerfile:
* Используйте базовый образ python:3.12-slim
* Обязательно используйте конструкцию COPY . . в Dockerfile
* Создайте .dockerignore файл для исключения ненужных файлов
```docker
.git
.env
*.yaml
*.pdf
Dockerfile
LICENSE
README.md
```
* Используйте CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"] для запуска
```docker
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"] 
```
* Протестируйте корректность сборки
![04-docker-in-practice-1-1](images/4-1-1.png)

## Задача 2 (*)
1. Создайте в yandex cloud container registry с именем "test" с помощью "yc tool" . 
2. Настройте аутентификацию вашего локального docker в yandex container registry.
3. Соберите и залейте в него образ с python приложением из задания №1.
4. Просканируйте образ на уязвимости.
5. В качестве ответа приложите отчет сканирования.
![04-docker-in-practice-2-1](images/4-2-1.png)

[Отчет сканирования](images/vulnerabilities.csv)

