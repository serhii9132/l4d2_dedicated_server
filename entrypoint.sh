#!/bin/bash

steamcmd +force_install_dir ${HOME}/${DIR_SERVER}/ +login anonymous +app_update 222860 validate +quit

${DIR_SERVER}/srcds_run -game left4dead2 -port 27015 +map c1m1_hotel -norestart -console