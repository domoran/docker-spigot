from openjdk:8-jdk-alpine as build

RUN javac -version
RUN java -version

RUN apk --update add git openssh && \
    rm -rf /var/lib/apt/lists/* && \
rm /var/cache/apk/*

RUN mkdir -p /root/scripts
RUN cd /root/scripts && wget "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" -O BuildTools.jar

RUN cd /root/scripts && java -jar BuildTools.jar

RUN cd /root/scripts && tar cvfz /root/server.tar.gz *.jar

from openjdk:8-jdk-alpine 

COPY --from=build /root/server.tar.gz /root
RUN cd /root && tar xvzf server.tar.gz
RUN cd /root && mv spigot*.jar spigot.jar
RUN cd /root && mv craftbukkit*.jar craftbukkit.jar

RUN mkdir /server
WORKDIR /server

ADD eula.txt /server/eula.txt
add server.properties /server/server.properties

EXPOSE 25565

CMD ["java","-Xms512M","-Xmx1G","-XX:+UseConcMarkSweepGC", "-jar", "/root/spigot.jar"]


