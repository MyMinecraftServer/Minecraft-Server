#! /bin/bash
# using shebangs and .sh's to make the plebs happy, 
# neither are necessary and are redundant and dumb when already using a bash shell

### SCRIPT DESCRIPTION ###
# This script makes a file called start_command.sh to allow easy starting of the server.
# It uses spigot to produce a minecraft server jar which should be called spigot-*.jar, where * is some string.
# Once the script sucessfully makes start_command.sh and spigot-*.jar, refer to start_command.sh to edit server memory allocation
# If you want to use a new version of the spigot build (e.g. spigot jar doesnt support the most current minecraft version), 
# then delete BuildTools.jar, spigot-*.jar, and start_command.sh first
### END OF SCRIPT DESCRIPTION ###

### VARIABLES YOU CARE ABOUT ###
# version of Minecraft we want to build
minecraft_version="1.15.2"
# number of GB we want to ues to build jar file (not the same as GB to run server)
build_gb=8
# number of GB we want to ues to run the server
run_gb=8
### END OF VARIABLES YOU CARE ABOUT ###

# make sure we have prerequisites installed and install them if not:
java -help || sudo apt install default-jre -y
git --help || sudo apt install git -y
wget --help || sudo apt install wget -y
(screen -S test -m -d && screen -S test -X quit) || sudo apt install screen -y
clear

# check if Minecraft folder and make it if not
[ ! -d Minecraft ] && mkdir Minecraft
cd Minecraft

# download spigot tool to make Minecraft server and call it BuildTools.jar, 
# try running this command again if it fails, sometimes the https just times out and will work the 2nd time
[ ! -f BuildTools.jar ] && \
(wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar || \
(echo "Check that https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar exists." && \
echo "If not, look on https://hub.spigotmc.org for new jar file" && \
exit 1))

# build server jar file with specified version and use build_gb GB while building
[ ! -f spigot-"$minecraft_version".jar ] && \
java -Xmx"$build_gb"G -jar BuildTools.jar --rev "$minecraft_version"
# make sure spigot named the file right
[ ! -f spigot-"$minecraft_version".jar ] && \
(echo ".jar file made by spigot does not match the expected output" &&  \
echo "check that spigot made a jar file (not BuildTools.jar) and rename it spigot-""$minecraft_version"".jar" && \
exit 1)

# make file to run server
[ -f start_command.sh ] && exit 1
touch start_command.sh
echo "#! /bin/bash" >> start_command.sh
echo "java -Xmx""$run_gb""G -Xms""$run_gb""G -jar spigot-""$minecraft_version"".jar nogui" >> start_command.sh
chmod +x start_command.sh

# set up git credentials for backups
#git config credential.helper store
#git push
