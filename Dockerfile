FROM openjdk:8-alpine

RUN apk add --no-cache wget bash unzip sed

RUN wget https://media.forgecdn.net/files/5821/401/nomi-ceu-1.7.3-server.zip

RUN mkdir -p /minecraft/ && unzip nomi-ceu-1.7.3-server.zip -d /minecraft/ && chmod +x /minecraft/Install.sh

RUN chmod +x /minecraft/launch.sh

ADD eula.txt /minecraft/eula.txt
ADD server.properties /minecraft/server.properties
ADD ops.json /minecraft/ops.json
ADD mods/* /minecraft/mods/
RUN sed -i -e "s/MIN_RAM='2048M'/MIN_RAM='8G'/g" /minecraft/launch.sh && \
	sed -i -e "s/MAX_RAM='2048M'/MAX_RAM='16G'/g" /minecraft/launch.sh


CMD cd /minecraft/ && ./launch.sh