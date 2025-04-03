
#!/bin/bash

cd ~/server

# Send a message to players: Restarting in 1 minute
screen -S minecraft -p 0 -X stuff "say Server will restart in 1 minute...$(printf '\r')"
sleep 60

# Notify about restart
screen -S minecraft -p 0 -X stuff "say Restarting now...$(printf '\r')"

# Stop the server
screen -S minecraft -X quit
sleep 5

# Restart the server
screen -dmS minecraft ./run.sh
