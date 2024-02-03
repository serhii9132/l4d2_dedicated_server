FROM ubuntu:noble-20231221

ARG USER_NAME=steam_user
ARG USER_ID=47120
ENV PATH_SERVER=/home/${USER_NAME}/files_server

EXPOSE 27015/tcp
EXPOSE 27015/udp

# Setting up the system and installing dependencies for steamcmd
RUN dpkg --add-architecture i386 && apt-get update -y \
    && apt install -y locales && locale-gen en_US.UTF-8 \
    && echo steam steam/question select "I AGREE" |  debconf-set-selections \
    && echo steam steam/license note '' | debconf-set-selections \ 
    && apt install -y curl steamcmd gdb lib32gcc-s1 lib32stdc++6 libstdc++6:i386 lib32z1 \
    && rm -rf /var/lib/apt/lists/* \
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