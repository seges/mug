Mug development workbench
=========================

![alt text](http://pixabay.com/static/uploads/photo/2012/04/13/11/48/coffee-mug-32046_640.png "mug")

Mug helps you not to install your development workbench. It should always be easy as drinking from a mug ;)

# Requirements

* bash
* curl
* python

# Install

```
curl https://github.com/seges/mug/raw/master/setup.sh | sudo sh
```

# Run

## Existing project

```
cd <project_dir>
mug
```

## New project

When you want to create a new project and you want to utilize the environment:

```
cd <workspace_dir>
mug <module>
```

Where **module** is one of:

* backend-java
* backend-scala
* frontend-javascript

## Configuration

It is possible to define some project or workbench common parameters not included in the main code of mug to keep it reusable. You can create **.mugrc** file in your **home** directory with following possible values:

| Parameter | Description
| --------- | ---------------
| mug_data  | Specifies mug data container to be run for every mug execution if it is not already running. See [Custom project/workbench data][#custom-projectworkbench-data].

## Custom project/workbench data

Imagine the situation you need to provide project or company specific data, e.g. default "settings.xml" in Maven repository or common configuration file for git. But such data is specific to the project or the company. In order not to modify the module image each time and have it generic, you should follow the Docker's pattern of data containers.

It is possible to add project or workbench specific data into the module image by providing additional Docker container with specific name **mug-data**. If such container exists, *mug* will include it as "volumes-from". If it is specified in the mug configuration parameter **mug_data**, it will be automatically started if it is not runnig.

There is a short-cut to run the data container manually for whatever reason:

```
mug-data acme/mug-data
```

## Runtime initialization

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

