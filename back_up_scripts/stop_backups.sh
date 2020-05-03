#! /bin/bash
# kill the screen that is running the backup script
# (backup script must be running in minecraftbackup screen)
screen -p 0 -S minecraftbackup -X quit
