# docker-spigot
A container that will build an up-to-date minecraft server  (spigot) from the spigotMC build tools. 


To build the image for a specific server version (i.e. 1.12.2): 

docker build -t docker-bukkit-1.12.2 --build-arg version=1.12.2 .

To run the container: 

docker run -d -it --name mcn -p 25565:25565 -p 25575:25575 -v /minecraft_spigot:/server docker-bukkit-1.12.2
