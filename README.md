# rbejar/docker-modelio (Modelio 4.1 in a Docker container)

Forked from <https://github.com/olberger/docker-modelio> in order to add an option to modelio-wrapper to launch Modelio directly, without opening first a shell in the container and expecting the user to type `modelio.sh` from there.

As in the original repo, OpenJDK 11 is installed inside the container in `/usr/local/openjdk-11` (for use in Java Designer module's parameters).

## Installation (Linux)

You have to build the image yourself, just the first time, from the contents of the Github repo. This image is not available in Dockerhub:

```bash
docker build -t rbejar/docker-modelio github.com/rbejar/docker-modelio
```

Once done that, install the wrapper script by running `run-linux.sh`.

This will install a wrapper script named  `modelio-wrapper` to launch modelio.

## Installation (macOS)
Untested, but it might work; follow the instructions in the [original repository](https://github.com/olberger/docker-modelio).

## Warnings, requirements etc.
You should read the README.md in the [original repository](https://github.com/olberger/docker-modelio).

## Modelio workspace and configuration
By default, the container will save the Modelio projects in your computer (via bind mounts) in `$HOME/Documents/ModelioWorkspace/` and the configuration in `$HOME/.modelio/`. These are sensible defaults, but you can change them with the `-p` parameter in `modelio-wrapper` (see the original repo for details).

## Starting Modelio
You can launch Modelio with this command:

```bash
modelio-wrapper modelio
```

If you want to increase the number of available CPUs for better perfomance, you can launch it like this (for example, with 4 CPUs, which works much better than the default 2):

```bash
modelio-wrapper -c 4 modelio
```

You can still launch Modelio as proposed in the original repositoriy. This enters a shell inside the Docker container where you must run `modelio.sh` if you prefer to do so:

```bash
modelio-wrapper bash
```


