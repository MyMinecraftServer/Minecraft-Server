cd Minecraft/

rm -r apache* work
rm BuildTools* bukkit*

cd BuildData
git pull
cd ../Bukkit
git pull
cd ../CraftBukkit
git pull
cd ../Spigot
git pull
