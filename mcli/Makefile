# Makefile for standalone Music service (S2)

VER=v0.8

# this is needed to switch M1 Mac to x86 for compatibility with x86 instances/students
ARCH=--platform x86_64

SERVER=`docker inspect s2 --format '{{.NetworkSettings.IPAddress}}'`
PORT=30001

build-mcli:
	docker image build $(ARCH) -f Dockerfile -t mcli:$(VER) .

run-mcli:
	docker container run $(ARCH) -it --rm --name mcli mcli:$(VER) python3 mcli.py $(SERVER) $(PORT)
