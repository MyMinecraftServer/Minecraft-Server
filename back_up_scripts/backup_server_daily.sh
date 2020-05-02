sleep 5m
./stop_minecraft_server.sh

# git add Minecraft/world/* Minecraft/world_nether/* Minecraft/world_the_end/* Minecraft/*.yml  Minecraft/*.json
# git commit -am "daily backup"
# git push

new_minecraft_dir=Minecrafr_backup_`date +"%s"`
mkdir new_minecraft_dir
cp Minecraft/world/ $new_minecraft_dir/
cp Minecraft/world_nether/ $new_minecraft_dir/
cp Minecraft/world_the_end/ $new_minecraft_dir/
cp Minecraft/*.yml $new_minecraft_dir/
cp Minecraft/*.json $new_minecraft_dir/
cp Minecraft/*.properties $new_minecraft_dir/

./start_minecraft_server.sh
