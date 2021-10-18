# Introduction to Containers

### This course provides a gentle introduction to containers. It is best used in conjunction with the official [Docker Documentation](https://docs.docker.com/).
---
## Table of Contents
 - [What is Docker?](#what-is-docker)
 - [Building a Docker Image](#building-a-docker-image)
---
## What is Docker?
### Docker is simply a container runtime, there are multiple types of container runtimes (some of which you have probably heard of), some popular ones are:
* Docker <- `You are here`
* rkt
* mesos
* LXC
* OpenVZ
* containerd
  
### This course will focus on the docker runtime, but the architecture of most runtimes are somewhat similar, though they may do somethings different or call things by other names.
---
### 1. What is or isn't a container?
* A container is **NOT** a VM
* A container is essentially just files (since everything on linux is a file)
* A container normally loses its state when shutdown (though some confi gurations can change this)
* A container runs isolated processes (the container itself is a process)
* A container uses namespaces to limit syscalls that interact with the kernel. These namespaces may or may not be the actual native kernel namespaces (depending on the product you use) though they typically represent:
  * processes
  * storage
  * network
  * users
  * groups
---
### 2. What makes a container special?
* They are self contained (meaning they ***normally*** do not effect the host configuration)
* They are their own process (meaning they have a PID of 1 and do not rely on a parent process) 
* They are more similar to a chroot than a VM
* They have minimal overhead since the resources are an abstraction layer and not virutalized.




### A good visualization of a container vs a VM is this.
<img src="https://www.docker.com/sites/default/files/d8/2018-11/container-vm-whatcontainer_2.png" alt="VM" style="width:400px;height:400px"></img>
<img src="https://www.docker.com/sites/default/files/d8/2018-11/docker-containerized-appliction-blue-border_2.png" alt="Containers" style="width:400px;height:400px"></img>

##### source: docker.com

* Notice that a VM has it's own operating system with it's own kernel, meaning that the CPU/RAM all have to be virtualized as well. 
* An easier way to think about containers would be that the host machine's kernel is using namespaces as a type 2 hypervisor, while the docker runtime is the VM, and the containers are essentially hard drives. 
* Once again, not a *correct* statement but **more** correct than saying a container is a VM.
---


### 3. So what are containers good for?
* Standardizing an environment for an application
* Isolating an application from the rest of the file system
* Needing ***virtualish*** components (network/filesystem/users/groups/processes) on a low resource system
* Needing a way to easily deploy and configure an application which may rely on a specific device configuration
---
## Docker Command Overview
This section gives some background regarding common docker uses and the commands associated with them. A majority of commands have additional options that can be added to them. (ex. `docker volume` -> `docker volume create`)

The following commands are not made to be ran verbatim as most require additional options to work properly, it is simply used to innoculate you from the vast amount of commands you will see while reading the docker documentation.

### Building
A container is built using a **Dockerfile**.
These docker files usually consist of a base image, commands, and any other configurations that may be needed to ensure the application's requirements are fully satisifed during runtime. After authoring a Dockerfile, you can use the `docker build` command to create a docker image, that can easily be distributed and ran by other with a docker runtime.

### Running
The docker images that you build or download can then be ran using the `docker run` command.

### Updating
When updating a docker image (changing the source code, updating a dependency, etc...), you must rebuild it with the `docker build` command.

### Distributing
After building an image, it may be useful to distribute the image, this is done using the `docker tag` followed by a `docker push` command.

### Persisting
Everytime a docker image is stopped and brought back up, it *should* come up in a prestine state. This means anything that you may have changed will be reverted (kind of like a deep freeze). This isn't exactly useful as most applications require some sort of state storage (a database, list of users, created files, etc...) This issue is solved by using the `docker volume` command and allows you to create a storage volume that is stored on the host machine, that volume can then be mapped into a running container using the `-v` switch. example: `docker run -v NameOfCreatedVolume:/your/mount/point/inside/container`

---
