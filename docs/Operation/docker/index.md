# Docker

## CheatSheet

<https://dockercheatsheet.com/>

## Installation

### Linux

Automatic

```docker
curl -sSL https://get.docker.com/ | sh
```
Manual

```docker
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(source /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

# Install docker components
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### Test for successful installation

```docker
docker run hello-world
```

## Cheat Sheet

### Lifecycle

```docker
• docker create • Creates a container but does not start it
• docker rename • Allows the container to be renamed
• docker run • Creates and starts a container in one operation
• docker rm • Deletes a container
• docker update • Updates a container’s resource limits
• docker run --rm • Removes container when stopped
• docker rm -v • Removes volumes associated with container
• docker run --log-driver=syslog • Runs Docker with custom log driver
```

### Starting and Stopping

```docker
• docker start • Starts a container, so it is running
• docker stop • Stops a running container
• docker restart • Stops and starts a container
• docker pause • Pauses a running container, “freezing” it in place
• docker unpause • Unpauses a running container
• docker wait • Blocks until running container stops
• docker kill • Sends a SIGKILL to a running container
• docker attach • Connects to a running container
```

### Processes and Performance

```docker
• docker ps • Shows running containers
• docker logs • Gets logs from container; you can use a custom log driver, but logs are only available for json-file and journald in 1.10
• docker inspect • Looks at all the info on a container (including IP address)
• docker events • Gets events from container
• docker port • Shows public facing port of the container
• docker top • Shows running processes in container
• docker stats • Shows containers’ resource usage statistics
• docker diff • Shows changed files in the container’s filesystem
• docker ps -a • Shows running and stopped containers
• docker stats --all • Shows a running list of containers
```

### Executing Commands

```docker
• docker exec • Executes a command in container

# To enter a running container, attach a new shell process to a running container called foo, use:
• docker exec -it foo /bin/bash.
```

### Lifecycle of Containers

Create, Run, Build, Commit

```docker
• docker images • Shows all images
• docker import • Creates an image from a tarball
• docker build • Creates image from Dockerfile
• docker commit • Creates image from a container, pausing it temporarily if it is running
• docker rmi • Removes an image
• docker load • Loads an image from a tar archive as STDIN, including images and tags
• docker save • Saves an image to a tar archive stream to STDOUT with all parent layers, tags
```

### Remove

Remove all images

```docker
docker rmi -f $(docker images -q)
```

Remove all containers

```docker
docker rm -f $(docker ps -qa)
```

#### Example

```docker
# Load an image from file
docker load < my_image.tar.gz

# Save an existing image
docker save my_image•my_tag > my_image.tar.gz
docker save my_image•my_tag --output my_image.tar

# compress tar file to xz
xz --compress my_image.tar 
```

Import/Export Container

```docker
# Import a container as an image from file
cat my_container.tar.gz | docker import - my_image•my_tag

# Export an existing container
docker export my_container > my_container.tar.gz
```

### Info

```docker
• docker history • Shows the history of image
• docker tag • Tags an image to a name (local or registry)
```

### Backup / Restore

Import / Export

```docker
• docker cp • Copies files or folders between a container and the local filesystem
• docker export • Turns container filesystem into tarball archive stream to STDOUT
```

## Private and Public Registries/Repositories

A repository is a hosted collection of tagged images that, together, create the file system for a container.
A registry is a host -- a server that stores repositories and provides an HTTP API for managing the uploading and downloading of repositories.
**Docker.com** hosts its own index to a central registry (the Docker Hub) which contains a large number of repositories.

```docker
• docker login • Logs into a registry
• docker logout • Logs out from a registry
• docker search • Searches registry for image
• docker pull • Pulls an image from registry to local machine
• docker push • Pushes an image to the registry from local machine
```

## Docker Compose

The configuration file. Sets up a Docker container when you run docker build on it. **Sections/Directives** in a Dockerfile:

```docker
» .dockerignore • Files and directories to be ignored during the build -t of the Dockerfile

» FROM • Sets the base image for subsequent instructions

» MAINTAINER • Sets the Author field of the generated images

» RUN • Executes any commands in a new layer on top of the current image and commits the results

» CMD • Provides defaults for an executing container

» EXPOSE • Informs Docker that the container listens on the specified network ports at Docker Cheat Sheet (2016) Linux Academy- 6 - runtime; does not make ports accessible

» ENV • Sets environment variables

» ADD • Copies and Extract new files, directories or remote file to container; invalidates caches; avoid ADD and use COPY instead; Also use in copy from an URL

» COPY • Copies new files or directories to container

» ENTRYPOINT • Configures a container that will run as an executable

» VOLUME • Creates a mount point for externally-mounted volumes or other containers

» USER • Sets the username for following RUN/CMD/ENTRYPOINT commands

» WORKDIR • Sets the working directory

» ARG • Defines a build-time variable

» ONBUILD • Adds a trigger instruction when the image is used as the base for another build

» STOPSIGNAL • Sets the system call signal that will be sent to the container to exit

» LABEL • Apply key/value metadata to your images, containers or daemon
```

## Links Between Containers

Links are how Docker containers talk to each other through TCP/IP ports. As of 0.11, you can resolve links by hostname.

If you want containers only to communicate with each other through links, start the docker daemon with `-icc=false` to disable interprocess communication.

If you have a container with the name CONTAINER (specified by docker run --name CONTAINER) and in the Dockerfile, it has an exposed port: `EXPOSE 8080` Then if we create another container called LINKED:

`docker run -d --link CONTAINER•ALIAS --name LINKED user/example`

The exposed ports and aliases of CONTAINER will show up in LINKED with the following environment variables:

```bash
$ALIAS_PORT_8080_TCP_PORT
$ALIAS_PORT_8080_TCP_ADDR
```

And you can connect to it that way to delete links, use `docker rm --link`

## Volumes

Docker volumes are free-floating filesystem. They don’t have to be connected to a particular container.

You could use volumes mounted from data-only containers for portability.

### Docker Volume Lifecycle

```docker
• docker volume create
• docker volume rm

# Volume Information
• docker volume ls
• docker volume inspect
```

## Ports

`EXPOSE` is used to document which ports are expected to be used by the containerized application, while `port publishing PUBLISH` (or -p) is used to actually make those ports accessible from outside the container by mapping them to ports on the host machine.

### Expose

EXPOSE is a keyword in a Dockerfile that specifies a port number that the container listens on. When you use EXPOSE, you're telling Docker that your application listens on a specific port. This information is stored in the Docker image's configuration.

It ***does not actually publish the ports*** or make them **accessible** from outside the container.

When you `EXPOSE` a port in a Dockerfile, you're essentially documenting that the containerized application or service running inside the container is **expected** to listen on that port for incoming connections.

It serves as a form of documentation for developers and users to understand which ports are intended to be used for communication with the containerized application.

### Publish

PUBLISH is a command-line option when running a Docker container. **It maps a container port to a host port**. When you use PUBLISH, you're telling Docker to forward traffic from the host machine to the container.

## Frequency Use Commands

### docker privilege

Add user to docker group

```docker
sudo usermod -aG <docker-grp> <user-name>

# Activate without logout
sudo exec newgrp <docker-grp>
```

Add insecure docker registry to bypass TLS error

```docker
sudo vim /etc/docker/daemon.
{
  "insecure-registries":
  [
      "<private-registry-domain:port_number>",
  ]
}

sudo systemctl daemon-reload
sudo systemctl restart docker.service
sudo systemctl status docker.service
```

### docker repository

Get a list of local registry

```docker
curl localhost:5000/v2/_catalog
```

### docker images

Output filter over columns

```docker
docker images --format '{{.Repository}}:{{.Tag}}'
```
