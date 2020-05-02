backup_path=/media/user/disk/Minecraft_backups
sleep 7d
./stop_minecraft_server.sh
sleep 1m

# git add Minecraft/world/* Minecraft/world_nether/* Minecraft/world_the_end/* Minecraft/*.yml  Minecraft/*.json
# git commit -am "daily backup"
# git push

new_minecraft_dir="$backup_path"/Minecraft_backup_`date +"%s"`
mkdir $new_minecraft_dir
cp -r Minecraft/world/ $new_minecraft_dir/
cp -r Minecraft/world_nether/ $new_minecraft_dir/
cp -r Minecraft/world_the_end/ $new_minecraft_dir/

./start_minecraft_server.sh
