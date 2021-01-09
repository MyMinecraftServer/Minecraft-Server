#! /bin/bash
# send the stop command to minecraft server
screen -p 0 -S minecraft -X eval 'stuff "stop"\015'
# stop backup script
screen -p 0 -S minecraftbackup -X quit
screen -ls
