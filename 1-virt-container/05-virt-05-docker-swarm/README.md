# Домашнее задание к занятию 6. «Оркестрация кластером Docker контейнеров на примере Docker Swarm»
## Задача 1
Создайте ваш первый Docker Swarm-кластер в Яндекс Облаке. Документация swarm: https://docs.docker.com/engine/reference/commandline/swarm_init/

1. Создайте 3 облачные виртуальные машины в одной сети.
![05-virt-05-docker-swarm-5-1-1](images/5-1-1.png)
2. Установите docker на каждую ВМ.
3. Создайте swarm-кластер из 1 мастера и 2-х рабочих нод.
4. Проверьте список нод командой:
```bash
docker node ls
```
![05-virt-05-docker-swarm-5-1-2](images/5-1-2.png)



