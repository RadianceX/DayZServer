# Docker Compose configuration for self-hosted DayZ server

## Prerequisites

- Docker 28.2.2 or newer
- Docker Compose 2.37.1 or newer
- Steam account with purchased DayZ

## Configure credentials

To run the server you must login into account with purchased Dayz.
Docker-compose uses following variables from .env file to log into steam   

``` txt
STEAM_CMD_USER=<steam account login>
STEAM_CMD_PASSWORD=<steam account password>
```

## Configure server

Edit ./serverDZ.cfg

## Install mods

Follow this guide https://steamcommunity.com/app/221100/discussions/0/4794664409789522473/ to install mods

## Run the server

Execute following command in the terminal
```
docker compose up --build --force-recreate
```

## Connect from DayZ Launcher

- Run DayZ Launcher
- Go to Parameters > ALL PARAMETERS tab
- Go to Client section and set following parameters
  - Server address: 127.0.0.1
  - Server Port: 2306
  - Server Password: 123456