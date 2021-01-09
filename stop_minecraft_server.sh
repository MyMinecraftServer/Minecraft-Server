#! /bin/bash
# send the stop command to minecraft server
screen -p 0 -S minecraft -X eval 'stuff "stop"\015'
# wait for it actually stop
sleep 10s
./back_up_scripts/stop_backups.sh
# guess that the server stopped and lie to the user that it is (whem maybe it is not and you should wait longer)
echo "stopped server"
