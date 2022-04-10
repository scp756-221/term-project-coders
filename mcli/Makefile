# Makefile for standalone Music service (S2)

VER=v0.8

# this is needed to switch M1 Mac to x86 for compatibility with x86 instances/students
ARCH=--platform x86_64

S1=`docker inspect s1 --format '{{.NetworkSettings.IPAddress}}'`
S2=`docker inspect s2 --format '{{.NetworkSettings.IPAddress}}'`
S3=`docker inspect s3 --format '{{.NetworkSettings.IPAddress}}'`

S1_PORT=30000
S2_PORT=30001
S3_PORT=30003

SERVICE_TYPE=user # starting with JWT authentivation

build-mcli:
	docker image build $(ARCH) -f Dockerfile -t mcli:$(VER) .

run-mcli:
	docker container run $(ARCH) -it --rm --name mcli mcli:$(VER) python3 mcli.py $(S1) $(S2) $(S3) $(S1_PORT) $(S2_PORT) $(S3_PORT)

check-IP:
	echo $(S1) $(S2)