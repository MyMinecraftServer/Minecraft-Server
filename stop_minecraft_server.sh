#! /bin/bash
# send the stop command to minecraft server
screen -p 0 -S minecraft -X eval 'stuff "stop"\015'
sleep 10s
echo "stopped server"
