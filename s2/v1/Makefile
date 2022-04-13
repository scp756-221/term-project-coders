# Makefile for standalone Music service (S2)
VER=v1
HOST_DIR=$(CURDIR)

# this is needed to switch M1 Mac to x86 for compatibility with x86 instances/students
ARCH=--platform x86_64

build-s2:
	docker image build $(ARCH) -f Dockerfile --build-arg EXERARG=$(VER) --build-arg ASSIGN=$(ASSIGN) -t s2:$(VER) .

run-s2:
	docker container run $(ARCH) -it --rm -p 30001:30001 -v $(HOST_DIR):/data --name s2 s2:$(VER)

# Run the container in detached mode and retain its logs---mostly used for testing
run-s2-detached:
	docker container run $(ARCH) -d  --rm -p 30001:30001 -v $(HOST_DIR):/data --name s2 s2:$(VER)