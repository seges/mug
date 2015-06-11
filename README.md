Mug development workbench
=========================

![alt text](http://pixabay.com/static/uploads/photo/2012/04/13/11/48/coffee-mug-32046_640.png "mug")

Mug helps you not to install your development workbench. It should always be easy as drinking from a mug ;)

It allows you to work in the same environment as it would be on the server in addition with development tools being run in Docker containers as well. You don't have to mess with /etc/hosts file because DNS is included and connected to service registry.

# Requirements

* bash
* curl
* python
* (optional) [cutlery](http://seges.github.io/cutlery)

# Install

```
curl -L https://github.com/seges/mug/raw/master/setup.sh | sudo sh
```

strongly recommended but still optional, install Cutlery

```
curl -L https://github.com/seges/cutlery/raw/master/setup.sh | sudo sh
```

# Example usage

```
# prepare environment after start of your computer
mug docker-base restart

# fire your favorite IDE, e.g.
mug eclipse
# your /home/<user>/development is automatically mapped to /home/developer/development directory in the container

# change some files and try to build it
cd /home/<user>/development/my-project
mug

# here we are in 'mug'
> cd my-project
# it executes mvn clean install
> mvnci

```

# Run

Mug's main purpose is to support your whole development lifecycle and therefore there are multiple options what to work with:

* Setup phase - start default Docker containers supporting your runtime environment - ambassador, discovery, etc...
* Development phase - jump to development environment and build, compile, etc...

## Setup phase

mug currently supports runtime environment (composition of your application containers, not composition of development containers) utilizing Consul and Ambassador. It is capable of preparing such environment as easy as:

```
mug docker-base restart
```

which:

* sets global DNS for every following container to the one provided by Consul at Docker's bridge interface
* starts [Progrium's Ambassador](https://github.com/progrium/ambassadord)
* starts [Consul](http://www.consul.io) with [Registrator](https://github.com/progrium/registrator)

It utilizes [Cutlery](http://seges.github.io/cutlery) project that contains basic scripts to work with such Docker environment.

## Development phase

### Existing project

```
cd <project_dir>
mug
```

### New project

When you want to create a new project and you want to utilize the environment:

```
cd <workspace_dir>
mug <module>
```

Where **module** is one of:

* backend-java
* backend-scala
* frontend-javascript

### Configuration

It is possible to define some project or workbench common parameters not included in the main code of mug to keep it reusable. You can create **.mugrc** file in your **home** directory or project workspace with following possible values:

| Parameter               | Description
| ----------------------- | ---------------
| default_iface           | default non-docker interface where services are advertised (e.g. Consul)
| mug_data                | Specifies mug data container to be run for every mug execution if it is not already running. See [Custom project/workbench data](#custom-projectworkbench-data).
| versions                | Overrides default (latest) or unspecified versions of images resolved for particular module. It contains space delimited list of named image artifacts: <repository>/<image>:<tag>. Example: ```versions="seges/mug-backend-java:oracle-java7 seges/mug-backend-scala:2.11"```
| development_dir         | Overrides default (/home/host_user/development) directory where workspace and source code is, so it is available to one of IDEs
| idea_variant            | Currently if set to "IU", it will use IntelliJ Idea Ultimate Trial. If not set, Community Edition will be used

#### Configuration resolution

mug by default includes the configuration found in your home directory.

In case you have multiple project workspaces with different requirements, e.g. different setup of versions for development containers where projectA requires Java version7 but projectB requires version 8, then you can override it by putting additional **.mugrc** file somewhere up the tree from the current directory, where mug starts.

Advice: it is good to place one .mugrc in root directory of the workspace or set of projects if they are related

Example directory structure:

```
/home/user
  |
  |- .mugrc
  |
  |- development
       |
       |- project A repo
       |    |
       |    |- .mugrc (this is project A specific and will be loaded on top of the home's one)
       |    |- projectA-api
       |    |- projectA-server
       |
       |- project B repo
            |
            |- .mugrc (this is project B specific and will be loaded on top of the home's one)
            |- projectB-common
            |- projectB-rest
```

### Custom project/workbench data

Imagine the situation you need to provide project or company specific data, e.g. default "settings.xml" in Maven repository or common configuration file for git. But such data is specific to the project or the company. In order not to modify the module image each time and have it generic, you should follow the Docker's pattern of data containers.

It is possible to add project or workbench specific data into the module image by providing additional Docker container with specific name **mug-data**. If such container exists, *mug* will include it as "volumes-from". If it is specified in the mug configuration parameter **mug_data**, it will be automatically started if it is not runnig.

There is a short-cut to run the data container manually for whatever reason:

```
mug-data acme/mug-data
```

### Runtime initialization

There is a possibility to initialize various aspects of the running environment, e.g. copying some workbench data upon start of the module container. It is strongly dependent on the module image implementation but images already implemented in mug have basic initialization routines.

Data that should be provided is usually contained either in:
* module image's directory
* mug-data image

If you want to know more about the support for initialization in provided modules, take a look in the appropriate documentation of the module. In case you want to utilize the support in mug, you have to:
* copy ```entrypoint.sh``` to your Docker context
* create ```docker-entrypoint.d``` and include all initialization scripts inside
* put following lines in Dockerfile:
```
ADD entrypoint.sh /home/developer/
ADD docker-entrypoint.d/ /docker-entrypoint.d/

CMD ["sudo", "/home/developer/entrypoint.sh"]
```

## Developer tools

Execute it via:
```mug <tool command>```

### IDEs

Mug is capable of running your favourite IDEs:

| Command      | Tool name |
| ------------ | --------- |
| eclipse      | Eclipse IDE - EE version |
| idea         | IntelliJ Idea - by default Community Edition is run, see *idea_variant* configuration option |

connected to your local workspace. It mounts ```/home/<user>/development``` directory by default to the container's environment into ```/home/developer/development```. It can be overriden by Mug configuration.

### Oracle

| Command      | Tool name |
| ------------ | --------- |
| oracle       | Oracle XE database. Registered service *oracle-dev.service.consul*, 49161 port for DB connection. More on [wnameless github](https://github.com/wnameless/docker-oracle-xe-11g). |
| sqldeveloper | Oracle SQL Developer. More on [guywithnose Docker hub](https://registry.hub.docker.com/u/guywithnose/sqldeveloper) |

### Other

| Command      | Tool name |
| ------------ | --------- |
| net          | Various pre-installed network-related tools that you don't have to install yourself on your workstation (e.g. nmap, nslookup, dig,...) |
| monitor      | monitor your containers in a fancy console utilizing nice [docker-mon project](https://github.com/icecrime/docker-mon) |

# Helpers

## Discovery

Open the UI for service discovery

```
mug discovery
```

## Docker

| Action                 | Command                |
| ---------------------- | ---------------------- |
| Clean stale images     | ```mug clean images``` |
| Clean stale containers | ```mug clean ps```     |

# Modules

## backend-java

Copies /home/developer/home-init.d into /home/developer and /home/developer/.m2.tmpl into /home/developer/.m2/repository

## backend-scala

Copies ivy cached dependencies

## frontend-javascript

# Development

* implement a Docker image inside "docker" directory
* extend ```bin/mug``` script in order to properly identify the project
* add initialization scripts in /docker-entrypoint.d using ADD or COPY
** use ```entrypoint.sh``` as your main command

Use ```docker-build.sh``` and ```docker-push.sh``` commands to prepare images.

