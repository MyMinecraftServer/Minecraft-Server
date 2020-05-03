#! /bin/bash
### SCRIPT DESCRIPTION ###
# This script is to start a miecraft server made by make_minecraft_server.sh
# It calls start_command.sh to run server. To change how much memory the server uses,
# edit Minecraft/start_command.sh
# To see the screen the server is running in, use command: screen -r minecraft
# To detach screen (put back in background), hold Ctrl+a+d in the shell the screen is running.
### END OF SCRIPT DESCRIPTION ###

# flag for determining wether to backup server periodically automatically
# world files must be located in Minecraft/world Minecraft/world_nether and Minecraft/world_the_end
# all of which must be in Minecraft-server folder that contains this script
use_backup=1

# check that we have Minecraft folder and advise user to run make server command
[ ! -d Minecraft ] && (echo "must run make_minecraft_server.sh first to make Minecraft folder" && exit 1)
cd Minecraft
# remove possible previous memory error logs
[ -f hs_err_*.log ] && rm hs_err_*.log
# premptively make eula file Minecraft cares about
[ -f eula.txt ] || (touch eula.txt && echo "eula=true" >> eula.txt)
# show or user what command is about to be run in new screen
tail -n 1 start_command.sh
# run our minecraft server in a screen called minecraft and add gamerules to server
echo "minecraft server started in minecraft screen"
screen -S minecraft -d -m ./start_command.sh
screen -p 0 -S minecraft -X eval 'stuff "gamerule mobGriefing false"\015'
# wait to see if any errors occur
sleep 1s
# print out any memory errors
[ -f hs_err_*.log ] && (cat hs_err_*.log && \
echo "The server is likely wanting too much memory. Lower the value in Minecraft/start_command.sh (java -Xmx**G -Xms**G)" \
&& rm hs_err_*.log)

if [ $use_backup -eq 1 ]
then
	cd ..
	echo "running back-up in minecraftbackup screen"
	#screen -S minecraftbackup -m -d
	#screen -p 0 -S minecraftbackup -X ./back_up_scripts/backup_server_daily.sh
	./back_up_scripts/backup_server_daily.sh
fi
