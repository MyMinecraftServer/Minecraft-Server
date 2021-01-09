#! /bin/bash
# *** Must run this script from parent folder (Minecraft-server)
# if run in back_up_scripts, start and stop server will not work ***
# full path to where we want to save our backups
# *** Must  create this folder yourself ***
backup_path=./Minecraft_backups
# time length between backups
days_between_backups=7

echo "backing up every ""$days_between_backups"" days"
# wait time length
sleep "$days_between_backups"d

# stop server to prevent data from being corrupted
screen -p 0 -S minecraft -X eval 'stuff "stop"\015'
sleep 10s
# make a backup folder based off of current time in given folder
new_minecraft_dir="$backup_path"/Minecraft_backup_`date +"%s"`
mkdir $new_minecraft_dir
# copy all world files to backup folder
cp -r Minecraft/world/ $new_minecraft_dir/
cp -r Minecraft/world_nether/ $new_minecraft_dir/
cp -r Minecraft/world_the_end/ $new_minecraft_dir/
# restart server
./start_minecraft_server.sh
