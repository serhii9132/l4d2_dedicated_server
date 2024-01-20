FROM ubuntu:noble-20231221
RUN apt update

ARG USER_NAME=steam_user
ARG USER_ID=47120
ENV DIR_SERVER=files_server

RUN useradd --shell /bin/bash --create-home --uid ${USER_ID} --user-group ${USER_NAME}

RUN dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt install -y locales \ 
    && locale-gen en_US.UTF-8

RUN echo steam steam/question select "I AGREE" |  debconf-set-selections \
    && echo steam steam/license note '' | debconf-set-selections \ 
    && apt install -y curl steamcmd gdb lib32gcc-s1 lib32stdc++6 libstdc++6:i386 lib32z1 \
    && ln -s /usr/games/steamcmd /usr/bin/steamcmd

WORKDIR /home/${USER_NAME}
RUN mkdir /home/${USER_NAME}/${DIR_SERVER}
COPY entrypoint.sh /home/${USER_NAME}/entrypoint.sh
RUN chown ${USER_NAME}:${USER_NAME} entrypoint.sh

USER ${USER_NAME}

EXPOSE 27015/udp
EXPOSE 27015

# RUN mkdir -p .steam/sdk32 \
#     && ln -s /home/steam_user/files_server/bin/steamclient.so /home/steam_user/.steam/sdk32/steamclient.so 

#ENTRYPOINT [ "/bin/bash" ]