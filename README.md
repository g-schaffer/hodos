# Hodos

## Requirements

First you will need [Docker](https://docs.docker.com/get-docker/) and [Docker-compose](https://docs.docker.com/compose/install/) installed on your machine.

When use emulator, your host must support `KVM` and have `xhost` installed.

## Configure Docker

Si vous êtes un utilisateur Linux , vous devrez accorder un accès root à Docker afin de l'utiliser dans l' environnement VS Code . Pour accorder l'accès root à Docker, vous devrez créer le groupe Docker et ajouter votre utilisateur.

### Suivez les étapes ci-dessous :

    Exécutez la commande suivante pour créer le groupe Docker  :

sudo groupadd docker

#### Ajoutez votre utilisateur au groupe docker .

sudo usermod -aG docker $USER

#### Sous Linux, vous pouvez également exécuter la commande suivante pour activer les modifications apportées aux groupes :

newgrp docker

#### Vérifiez si vous pouvez exécuter dockercommandes sans sudo depuis le terminal :

docker run hello-world


___


## First running

### 1- Run API and create database
```
make compose/django
```

### 2- Load fixtures
```
make django/run/fixtures
```

### 3- Run front with android-studio and emulator

### 4- Login with credentials
```
thomas.deschombeck@gmail.com
```
```
Aa.123456789
```

___

## Usage

:whale2: Run dev containers.
```bash
make compose/up # Up the compose
```

:iphone: Run Flutter containers. 
```bash
make compose/flutter # recommanded for flutter dev
```

:whale2: Run Django containers.
```bash
make compose/django # recommanded for django dev
```

### Flutter Run

#### Emulator
- Run the "make compose/flutter" or "make compose/up" without mobile plugged on the HOST

#### USB Android
- Down the stack
- plug your mobile on the HOST
- Run the "make compose/flutter" or "make compose/up"

#### Flutter run key commands
- r Hot reload. 🔥🔥🔥
- R Hot restart.
- h List all available interactive commands.
- d Detach (terminate "flutter run" but leave application running).
- c Clear the screen
- q Quit (terminate the application on the device).


## Sources

Dockerize Flutter app = https://blog.codemagic.io/how-to-dockerize-flutter-apps/ 
Github flutter image inspiration = https://github.com/matsp/docker-flutter