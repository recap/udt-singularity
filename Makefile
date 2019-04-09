#.PHONY: build

FILE=udt-server_amd64.simg
PORT=8090

build:
ifeq ("$(wildcard $(FILE))","")
	echo "here"
	sudo singularity build $(FILE) Singularity
endif

clean: 
	rm -rf $(FILE)

test: build
	singularity run $(FILE) test

run-server: build
	singularity run $(FILE) sendfile $(PORT)

run-client: build
	dd if=/dev/urandom  of=/tmp/10M.dat count=1024 bs=10240
	singularity run $(FILE) recvfile 127.0.0.1  $(PORT) /tmp/10M.dat /tmp/10M.dat.2
	rm /tmp/10M.dat*





