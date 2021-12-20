# olberger/docker-modelio

# Introduction

[Modelio](https://www.modelio.org) 4.1.0 in a docker container (for Linux, and maybe for macOS too)

The image uses [X11](http://www.x.org) unix domain socket on the host to enable display of the Modelio desktop app. These components are available out of the box on pretty much any modern linux distribution.

OpenJDK 11 is installed, inside the container in `/usr/local/openjdk-11` (for use in Java Designer module's parameters).


# WARNINGS

* Once Launched :
    * The host shares X11 socket and IPC with the container
    => This breaks container isolation, and the contained app can listen to all X11 events !
    * **The host shares your ~/.modelio/ and ~/Documents/ModelioWorkspace/ folders (by default) with the container.**
* Use it at your own risk !

# Getting started

## Requirements

* Docker (https://www.docker.com) running
* X11 (tested with https://www.xquartz.org on macOS Catalina 10.15.7) running

## Installation

Automated builds of the image are available on [Dockerhub](https://hub.docker.com/r/olberger/docker-modelio) and is the recommended method of installation.

```bash
docker pull olberger/docker-modelio:latest
```

Alternatively you can build the image yourself, from the contents of
the Github repo.

```bash
docker build -t olberger/docker-modelio github.com/olberger/docker-modelio
```

With the image locally available, install the wrapper script by running the following as root:

```bash
docker run -it --rm \
  --volume /usr/local/bin:/target \
  olberger/docker-modelio:latest install
```

This will install a wrapper script to launch `modelio`.

## Setup on Mac (perform once)

1. launch XQuartz
2. in Preferences -> Security check "Authenticate connections" and "Allow connections from network clients"
3. exit and re-launch XQuartz
4. clone this repository
    ```sh
    git clone https://github.com/pascalpoizat/docker-modelio
    ```
5. enter the repository
    ```sh
    cd docker-modelio
    ```
6. build (optional)
    ```sh
    docker build --tag docker-modelio:latest .
    ```
7. enable the `run.sh` script to be run
    ```sh
    chmod +x run.sh
    ```

## Starting Modelio

Launch the `modelio-wrapper` script to enter a shell inside the Docker container

```bash
modelio-wrapper bash
```

Then the prompt should be displayed like:
```
Adding user `modelio' to group `sudo' ...
Adding user modelio to group sudo
Done.
bash
launch modelio by invoking 'modelio.sh' at the bash prompt:
drawio@0b2fefbf45d2:~$
```

then type `modelio.sh`.

# Running on Mac

Launch the `run.sh` script

```sh
./scripts/modelio-wrapper bash
```
Then launch modelio (twice if it triggers an error at first launch)

# Maintenance

## Upgrading

To upgrade to newer releases:

  1. Download the updated Docker image:

  ```bash
  docker pull olberger/docker-modelio:latest
  ```

  2. Run `install` to make sure the host scripts are updated.

  ```bash
  docker run -it --rm \
    --volume /usr/local/bin:/target \
    olberger/modelio:latest install
  ```

## Uninstallation

```bash
docker run -it --rm \
  --volume /usr/local/bin:/target \
  olberger/docker-modelio:latest uninstall
```

## Local image rebuild

```bash
docker build --tag  olberger/docker-modelio:latest .
```

# Performance issues

Due to [performance issue with GTK3](https://github.com/ModelioOpenSource/Modelio/issues/11), the `docker run` command launched by the wrapper limits CPU usage. On a host with 8 cores (`lscpu` command), here follows the behaviour with
some values of CPU usage:

* 1.5 (core) : too slow, unusable
* 2.0 : slow
* 3.0 : convenient
* 4.0 : comfortable

Adjust the `CPUS=` variable definition in `modelio-wraper` script, depending on your needs.

## Contributing

If you find this image useful here's how you can help:

- Send a pull request with your awesome features and bug fixes
- Help users resolve their [issues](https://github.com/olberger/docker-modelio/issues?q=is%3Aopen+is%3Aissue).


## How it works

The wrapper scripts mounts the X11 socket in the launcher container (a Docker volume). The X11 socket allows for the user interface display on the host.

When the image is launched the following directories are mounted as volumes

- `${HOME}/.modelio`
- the `${PWD}/diagrams-from-host/` subdir, i.e. a subdir of the current directory
<!-- - `XDG_DOWNLOAD_DIR` or if it is missing `${HOME}/Downloads` -->
<!-- - `XDG_DOCUMENTS_DIR` or if it is missing `${HOME}/Documents` -->

This makes sure that the configuration of the tool are stored on the host and files saved are preserved in the current suddir, if places inside the special 'diagrams-from-host/' directory.

**Don't want to expose host's folders to Draw.io application?**

Add `DRAWIO_HOME` environment variable to namespace all draw.io folders:

```sh
export DRAWIO_HOME=${HOME}/draw.io
```


# Sources / inspiration

- this is a simple update from [https://github.com/GehDoc/docker-modelio](https://github.com/GehDoc/docker-modelio) with no use of the user's UID/GID
- solution to access the X11 display from [https://medium.com/@mreichelt/how-to-show-x11-windows-within-docker-on-mac-50759f4b65cb](https://medium.com/@mreichelt/how-to-show-x11-windows-within-docker-on-mac-50759f4b65cb)
- improved by Olivier Berger to create user at runtime and avoid rebuilding to tackle uid/gid into account, inspired by https://github.com/mdouchement/docker-zoom-us













