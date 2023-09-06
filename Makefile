docker_flutter_container_name := "hodos-flutter"
docker_django_container_name := "hodos-django"

de_flutter := docker exec -it $(docker_flutter_container_name)
de_django := docker exec -it $(docker_django_container_name)

# ==================================================================================== #
# HELPERS
# ==================================================================================== #

.DEFAULT_GOAL := help
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

# ==================================================================================== #
# COMPOSE SERVICES
# ==================================================================================== #
	
## compose/up: run services containers and emulator android
.PHONY: compose/up
compose/up:
	@docker-compose up --build -d && make flutter/run

## compose/down: stop and remove containers gracefully
.PHONY: compose/down
compose/down:
	@docker-compose down

## compose/flutter: run flutter app container
.PHONY: compose/flutter
compose/flutter:
	@docker-compose up --build -d flutter && make flutter/run

## compose/django: run django api container and run migrate
.PHONY: compose/django
compose/django:
	@docker-compose up --build django

# ==================================================================================== #
# FLUTTER CONTAINER
# ==================================================================================== #

## 
.PHONY: flutter/clean/graddle
flutter/clean/graddle:
	@$(de_flutter) /bin/bash -c "cd android && ./gradlew clean build"

## flutter/run: run emulator from containered flutter app
.PHONY: flutter/run
flutter/run:
	@xhost local:$USER && $(de_flutter) /bin/bash -c "flutter-android-run && flutter logs"

## flutter/run/test: run tests from containered flutter app
.PHONY: flutter/run/test
flutter/run/test:
	@$(de_flutter) /bin/bash -c "flutter test"

## flutter/bash: connect to the flutter container while running in parallel
.PHONY: flutter/bash
flutter/bash:
	@$(de_flutter) /bin/bash

# ==================================================================================== #
# DJANGO CONTAINER
# ==================================================================================== #

## django/run/makemigrations optional(entity=$1): run migration maker from containered django api
.PHONY: django/run/makemigrations
django/run/makemigrations:
	@$(de_django) /bin/bash -c "python manage.py makemigrations $(entity)"

## django/run/migrate: run migration from migration maker to database
.PHONY: django/run/migrate
django/run/migrate:
	@$(de_django) /bin/bash -c "python manage.py migrate"

# django/run/fixtures: load sample data (check fixtures folders)
.PHONY: django/run/fixtures
django/run/fixtures:
	@$(de_django) /bin/bash -c "python manage.py loaddata ./user_management/fixtures/user_test.json"

## django/run/test optional(args=$1): run tests from containered django api
.PHONY: django/run/test
django/run/test:
	@$(de_django) /bin/bash -c "python manage.py test $(args)"

## django/run/shell
.PHONY: django/run/shell
django/run/shell:
	@$(de_django) /bin/bash -c "python manage.py shell"

## django/bash: connect to the django container while running in parallel
.PHONY: django/bash
django/bash:
	@$(de_django) /bin/bash

## django/dump: connect to the django container while running in parallel
.PHONY: django/dump
django/dump:
	@$(de_django) /bin/bash -c "python manage.py dumpdata --indent 2 > ./db_dumped.json"

## django/loaddata: connect to the django container while running in parallel
.PHONY: django/loaddata
django/loaddata:
	@$(de_django) /bin/bash -c "python manage.py loaddata > ./user_management/fixtures/user_test.json"

## create super user django
.PHONY: django/superuser
django/superuser:
	@$(de_django) /bin/bash -c "python manage.py createsuperuser"
