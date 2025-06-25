#!/bin/bash

steamcmd +force_install_dir ${PATH_SERVER} +login anonymous +@sSteamCmdForcePlatformType windows +app_update 222860 validate +quit
steamcmd +force_install_dir ${PATH_SERVER} +login anonymous +@sSteamCmdForcePlatformType linux +app_update 222860 validate +quit

${PATH_SERVER}/srcds_run -game left4dead2 -port 27015 $@