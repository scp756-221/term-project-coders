# Makefile for standalone Music service (S2)

VER=v0.25
HOST_DIR=$(CURDIR)

# this is needed to switch M1 Mac to x86 for compatibility with x86 instances/students
ARCH=--platform x86_64

build-s3:
	docker image build $(ARCH) -f Dockerfile --build-arg EXERARG=$(VER) --build-arg ASSIGN=$(ASSIGN) -t s3:$(VER) .

run-s3:
	docker container run $(ARCH) -it --rm -p 30003:30003 -v $(HOST_DIR):/data --name s3 s3:$(VER)

# Run the container in detached mode and retain its logs---mostly used for testing
run-s3-detached:
	docker container run $(ARCH) -d  --rm -p 30003:30003 -v $(HOST_DIR):/data --name s3 s3:$(VER)

# Run with different port and volume mappings to demonstrate container mappings
# HOWEVER, if the client is running from another container connecting to this over the bridge
# network, it will use port 30001.  The host port mapping (20000) only is visible to clients
# running in the host OS, while containers use the container mapping (30001).
run-s3-odd:
	docker container run $(ARCH) -it --rm -p 20000:30001 -v $(HOST_DIR)/odd:/data --name s3-odd s3-standalone:$(VER)

# Build an s3 image with one copy of a file of random bytes
build-s3-1-file:
	docker image build $(ARCH) -f s3-1-file-Dockerfile --build-arg EXERARG=$(VER) --build-arg ASSIGN=$(ASSIGN) -t s3-1-file:$(VER) .

# Build an s3 image with two copies of a file of random bytes
build-s3-2-files:
	docker image build $(ARCH) -f s3-2-files-Dockerfile --build-arg EXERARG=$(VER) --build-arg ASSIGN=$(ASSIGN) -t s3-2-files:$(VER) .

# Build an entirely self-contained image of s3, including the music entries
build-s3-self:
	docker image build $(ARCH) -f self-Dockerfile --build-arg EXERARG=$(VER) --build-arg ASSIGN=$(ASSIGN) -t s3-self-contained:$(VER) .
