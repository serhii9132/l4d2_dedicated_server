FROM ubuntu:24.04

ARG USER_NAME
ARG USER_ID
ARG PATH_SERVER
ARG PORT_SERVER

ENV PATH_SERVER ${PATH_SERVER}

EXPOSE ${PORT_SERVER}/tcp

# Setting up the system and installing dependencies for steamcmd
RUN dpkg --add-architecture i386 && apt-get update -y \
    && echo steam steam/question select "I AGREE" |  debconf-set-selections \
    && echo steam steam/license note '' | debconf-set-selections \ 
    && apt install -y --no-install-recommends ca-certificates curl steamcmd gdb \
    && rm -rf /var/lib/apt/lists/* && apt-get clean \
    && ln -s /usr/games/steamcmd /usr/bin/steamcmd \
    # Creating a user for running the server
    && useradd --shell /bin/bash --create-home --uid ${USER_ID} --user-group ${USER_NAME} \
    && mkdir -p ${PATH_SERVER} && chown -R ${USER_NAME}:${USER_NAME} ${PATH_SERVER}

VOLUME ${PATH_SERVER}

WORKDIR /home/${USER_NAME}
    
COPY --chown=${USER_NAME}:${USER_NAME} scripts/entrypoint.sh /home/${USER_NAME}/entrypoint.sh

USER ${USER_NAME}

# Needed for the proper functioning of steamcmd
RUN mkdir -p .steam/sdk32 \
    && ln -s ${PATH_SERVER}/bin/steamclient.so /home/${USER_NAME}/.steam/sdk32/steamclient.so 

ENTRYPOINT [ "/bin/bash", "entrypoint.sh"]
CMD [ "-norestart -console -maxplayers 8 +map c1m1_hotel +sv_lan 0" ]