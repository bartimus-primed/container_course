+++
title = "Introduction to Containers"
outputs = ["Reveal"]
+++
# Introduction to Containers
- This course provides a gentle introduction to containers. It is best used in conjunction with the official [Docker Documentation](https://docs.docker.com/).
---
## Table of Contents
 - [What is Docker?](#what-is-docker)
 - [Building a Docker Image](#building-a-docker-image)

---
## What is Docker?
Docker is a container runtime there are multiple types of container runtimes. Popular rutimes are:
- {{% fragment %}}Docker <- `You are here` {{% /fragment %}}
- {{% fragment %}}rkt{{% /fragment %}}
- {{% fragment %}}mesos{{% /fragment %}}
- {{% fragment %}}LXC{{% /fragment %}}
- {{% fragment %}}OpenVZ{{% /fragment %}}
- {{% fragment %}}containerd{{% /fragment %}}

---
###### This course will focus on the Docker runtime.
- {{% fragment %}}The architecture of most runtimes are somewhat similar.{{% /fragment %}}
- {{% fragment %}}Some runtimes may refer to components by other names.{{% /fragment %}}

---
###### What is or isn't a container?
- {{% fragment %}}A container is <span style="color:red">**NOT**</span> a VM{{% /fragment %}}
- {{% fragment %}}A container is essentially just files (since everything on linux is a file){{% /fragment %}}
- {{% fragment %}}A container is stateless (reverts on shutdown){{% /fragment %}}
- {{% fragment %}}A container runs isolated processes (the container itself is a process){{% /fragment %}}

---
#### A container uses namespaces to interact with the kernel. 
These namespaces may or may not be the actual native kernel namespaces, they typically represent:
- {{% fragment %}}processes{{% /fragment %}}
- {{% fragment %}}storage{{% /fragment %}}
- {{% fragment %}}network{{% /fragment %}}
- {{% fragment %}}users{{% /fragment %}}
- {{% fragment %}}groups{{% /fragment %}}
---
###### What makes a container special?
- {{% fragment %}}They are self contained (meaning they ***normally*** do not effect the host configuration){{% /fragment %}}
- {{% fragment %}}They are their own process (meaning they have a PID of 1 and do not rely on a parent process){{% /fragment %}}
- {{% fragment %}}They are more similar to a chroot than a VM{{% /fragment %}}
- {{% fragment %}}They have minimal overhead since the resources are an abstraction layer and not virutalized.{{% /fragment %}}
---
###### A Visualization of a Container vs a VM is this.
<img src="https://www.docker.com/sites/default/files/d8/2018-11/container-vm-whatcontainer_2.png" alt="VM" style="width:400px;height:400px"></img>
<img src="https://www.docker.com/sites/default/files/d8/2018-11/docker-containerized-appliction-blue-border_2.png" alt="Containers" style="width:400px;height:400px"></img>

source: docker.com

---
## Important Difference
* A VM has it's own operating system with it's own kernel, meaning that the CPU/RAM all have to be virtualized as well. This causes significant overhead compared to a container.  
-
An easier way to think about containers would be that the host machine's kernel is using namespaces as a hypervisor, while the docker runtime is the VM, and each container is essentially a hard drive.
<span style="font-size:1rem">Not a *correct* statement but **more** correct than saying a container is a VM.</span>

---
### So what are containers good for?
- {{% fragment %}}Standardizing an environment for an application{{% /fragment %}}
- {{% fragment %}}Isolating an application from the rest of the file system{{% /fragment %}}
- {{% fragment %}}Needing ***virtualish*** components (network/filesystem/users/groups/processes) on a low resource system{{% /fragment %}}
- {{% fragment %}}Needing a way to easily deploy and configure an application which may rely on a specific device configuration{{% /fragment %}}

---
## Docker Command Overview
- This section gives some background regarding common docker uses and the commands associated with them. A majority of commands have additional options that can be added to them. 
- The following commands are not made to be ran verbatim as most require additional options to work properly. They are simply used to innoculate you from the vast amount of commands you will see while reading the docker documentation.

---
### Building
A container is built using a **Dockerfile**.
These docker files usually consist of a base image, commands, and any other configurations that may be needed to ensure the application's requirements are fully satisifed during runtime. That docker file can easily be distributed and ran by other docker runtimes. After authoring a Dockerfile, you can create a docker image using the command 

> `docker build`

---
### Running
The docker images that you build or download can then be ran using the command

> `docker run`

---
### Updating
When updating a docker image (changing the source code, updating a dependency, etc...), you must rebuild it with the command

> `docker build`

---
### Distributing
After building an image, it may be useful to distribute the image, this is done using the command
> `docker tag`

followed by the command

> `docker push`

---
### Persisting
Everytime a docker image is stopped and brought back up, it *should* come up in a prestine state. This means all changes will be reverted (kind of like a deep freeze). This isn't exactly useful as most applications require some sort of state storage (a database, list of users, created files, etc...) A persistant storage volume can be created by using the command 
> `docker volume`


---
### Storage Mapping
Once you create a storage volume that is stored on the host machine, that volume can then be mapped into a running container using the -v switch.

> <span style="font-size:1rem">`docker run -v NameOfCreatedVolume:/your/mount/point/inside/container`</span>