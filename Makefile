build:
	# Python 3.8
	docker build --build-arg PYTHON_VERSION=3.8 -f Dockerfile       -t nullstone/django:3.8       .
	docker build --build-arg PYTHON_VERSION=3.8 -f local.Dockerfile -t nullstone/django:3.8-local .
	# Python 3.9
	docker build --build-arg PYTHON_VERSION=3.9 -f Dockerfile       -t nullstone/django:3.9       .
	docker build --build-arg PYTHON_VERSION=3.9 -f local.Dockerfile -t nullstone/django:3.9-local .

tags:
	docker tag nullstone/django:3.9       nullstone/django
	docker tag nullstone/django:3.9-local nullstone/django:local

push:
	docker push nullstone/django
	docker push nullstone/django:3.9
	docker push nullstone/django:3.8

	docker push nullstone/django:local
	docker push nullstone/django:3.9-local
	docker push nullstone/django:3.8-local

