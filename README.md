# Minecraft Fabric Server (1.21.x+) - Linux Setup

This repository contains the necessary files to run a **Minecraft Java Edition Fabric server** for version **1.21.x and later** on a **Linux machine**.

## Requirements

- Java 17 or newer (Java 21 recommended)
- Linux-based OS (e.g., Ubuntu, Debian, CentOS)
- At least 2GB of RAM (4GB+ recommended)
- Internet access for initial setup

## Setup Instructions

### 1. Install Java (Example: Ubuntu Server 24.04)

```bash
sudo apt update
sudo apt install openjdk-21-jre -y
```

### 2. Install `screen`

```bash
sudo apt install screen -y
```

### 3. Create a Server Directory

In your home directory, create a folder to store the server files:

```bash
mkdir ~/server
cd ~/server
```

### 4. Download the Fabric Server Launcher

Go to the [official Fabric website](https://fabricmc.net/use/server/) and download the Fabric server launcher `.jar` file.

Place the downloaded `.jar` file (e.g., `fabric-server-launch.jar`) into your `~/server` directory.

### 5. Create the `run.sh` Script

Use a text editor like `nano` to create your startup script:

```bash
nano run.sh
```

Paste in the following template, adjusting the RAM values based on your available memory (2GB per user is a good rule of thumb):

```bash
#!/bin/bash
java -Xms2G -Xmx2G -jar fabric-server-launch.jar nogui
```

Save and exit, then make the script executable:

```bash
chmod +x run.sh
```

### 6. How to Start the Server

```bash
./run.sh
```

After that runs, you might have to press Control + C, then:

```bash
nano eula.txt
```

Change `eula=false` to `eula=true` and save.

### 7. (Optional) How to Setup Auto Restart

You can configure the server to automatically restart using a `cron` job and a simple script.

#### 1. Create `restart.sh`

In your server directory, create a file named `restart.sh`:

```bash
nano restart.sh
```

Add the following content:

```bash

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
```

Make it executable:

```bash
chmod +x restart.sh
```

#### 2. Add a Cron Job

Edit the crontab for your user:

```bash
crontab -e
```

Add the following line to restart the server every day at 4:00 AM (adjust as needed):

```bash
0 4 * * * /home/your-username/server/restart.sh
```

Replace `your-username` with your actual username.

Make sure your server is started inside a `screen` session named `minecraft`, e.g.:

```bash
screen -S minecraft ./run.sh
```
To get back to your screen you will use the command
```bash
screen -r minecraft 
```
