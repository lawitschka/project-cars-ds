FROM ubuntu:14.04

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y -qq \
      wget \
      lib32gcc1 \
      lib32stdc++6

# Create Steam user
RUN useradd -m steam
USER steam

# Create SteamCMD and DS directory
ENV STEAMCMD /home/steam/steamcmd
ENV SERVER /home/steam/server
RUN mkdir $STEAMCMD && \
    mkdir $SERVER

# Download SteamCMD
WORKDIR $STEAMCMD
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz && \
    rm steamcmd_linux.tar.gz

# Download DS
RUN ./steamcmd.sh +login anonymous \
                  +force_install_dir $SERVER \
                  +app_update 332670 validate \
                  +quit

# Ensure steamclient.so is accessible
RUN ln -s $STEAMCMD/linux32/steamclient.so $SERVER/lib32/steamclient.so

# Change working directory to server
WORKDIR $SERVER

# Create config dir and copy default config file
RUN mkdir config && cp config_sample/server.cfg config/

# Expose all ports
EXPOSE 8766 27015 27016 9000

# Run server
CMD ./DedicatedServerCmd -c config/server.cfg
