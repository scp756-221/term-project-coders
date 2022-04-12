# Makefile for test of Music service (S2)

VER=v0.8

SERVER=`docker container inspect s2 --format '{{.NetworkSettings.IPAddress}}'`

build-music_test:
	docker image build -f Dockerfile -t music_test:$(VER) .

# Do not use '-it' options because this will run in non-TTY environment as GitHub Action
run-music_test:
	docker container run --rm --name music_test music_test:$(VER) python3 music_test.py $(SERVER) 30001
