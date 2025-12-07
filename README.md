# Docker Compose configuration for self-hosted DayZ server

## Prerequisites

- Docker 28.2.2 or newer
- Docker Compose 2.37.1 or newer
- Steam account with purchased DayZ

## Configure credentials

To run the server you must login into account with purchased Dayz.
Update .env with the account info

``` txt
STEAM_CMD_USER=<steam account login>
STEAM_CMD_PASSWORD=<steam account password>
```

## Select mods to install

To install mods edit MOD_IDS in .env file. Scripts will automatically download mods when you start the container.

## Run the server

Execute following command in the terminal
```
docker compose up
```

## Connect from DayZ Launcher

- Run DayZ Launcher
- Go to tab Parameters > ALL PARAMETERS
- Go to Client section and set following parameters
  - Server address: 127.0.0.1
  - Server Port: 2306
