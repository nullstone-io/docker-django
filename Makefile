build:
	docker build -t nullstone/django:local -f local.Dockerfile .
	docker build -t nullstone/django .

push:
	docker push nullstone/django:local
	docker push nullstone/django
