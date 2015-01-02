Mug development workbench
=========================

![alt text](http://pixabay.com/static/uploads/photo/2012/04/13/11/48/coffee-mug-32046_640.png "mug")

Mug helps you not to install your development workbench. It should always be easy as drinking from a mug ;)

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

Where *module* is one of:

* backend-java
* backend-scala
* frontend-javascript

## Development

* implement a Docker image inside "docker" directory
* extend ```bin/mug``` script in order to properly identify the project
* add initialization scripts in /docker-entrypoint.d using ADD or COPY
** use ```entrypoint.sh``` as your main command

Use ```docker-build.sh``` and ```docker-push.sh``` commands to prepare images.

