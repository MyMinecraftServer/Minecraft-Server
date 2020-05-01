sleep 5m
./stop_minecraft_server.sh
git rm -r --cached Minecraft/*
git commit --amend -CHEAD
git push
git add Minecraft/world/* Minecraft/world_nether/* Minecraft/world_the_end/* Minecraft/*.yml  Minecraft/*.json
git commit -am "daily backup"
git push
./start_minecraft_server.sh