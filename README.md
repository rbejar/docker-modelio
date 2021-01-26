[Modelio](https://www.modelio.org) 4.1.0 in a docker container (for macOS)

# WARNINGS

* Once Launched :
    * The host shares X11 socket and IPC with the container  
    => This breaks container isolation, and the contained app can listen to all X11 events !
    * **The host shares your ~/.modelio/ and ~/modelio/ folders with the container.**
* Use it at your own risk !
# Requirements

* Docker (https://www.docker.com) running
* X11 (tested with https://www.xquartz.org on macOS Catalina 10.15.7) running

# Setup (perform once)

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
6. build
    ```sh
    docker build --rm -f "Dockerfile" -t modelio:latest .
    ```
7. enable the `run.sh` script to be run
    ```sh
    chmod +x run.sh
    ```

# Running

Launch the `run.sh` script

```sh
./run.sh
```

# Sources

- this is a simple update from [https://github.com/GehDoc/docker-modelio](https://github.com/GehDoc/docker-modelio) with no use of the user's UID/GID
- solution to access the X11 display from [https://medium.com/@mreichelt/how-to-show-x11-windows-within-docker-on-mac-50759f4b65cb](https://medium.com/@mreichelt/how-to-show-x11-windows-within-docker-on-mac-50759f4b65cb)