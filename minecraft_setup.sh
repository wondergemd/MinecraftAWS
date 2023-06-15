#!/bin/bash

# Update the system packages
sudo yum update -y

# Install Java/JDK
sudo yum install -y java-17-amazon-corretto-headless

# Verify Java version
java -version

# Download the Minecraft Server
wget https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar

# Run the server for the first time to generate files
sudo java -Xms1G -Xmx2G -jar server.jar nogui

# Agree to the EULA
echo "eula=true" > eula.txt

echo "#!/bin/bash

screen -p 0 -S minecraft -X eval 'stuff "say Server is shutting down in 30 seconds..."\015'
sleep 30
screen -p 0 -S minecraft -X eval 'stuff "stop"\015
sleep 10'" | sudo tee /etc/systemd/system/minecraft_shutdown.sh



# Create the Minecraft service file
echo "[Unit]
Description=Minecraft Server
Wants=network-online.target
After=network-online.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user

ExecStart=/usr/bin/screen -DmS minecraft sudo java -Xms1G -Xmx2G -jar server.jar nogui
ExecStop=/etc/systemd/system/minecraft_shutdown.sh

Restart=always
RestartSec=30

StandardInput=null

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/minecraft.service

# Enable the service to start on boot
sudo systemctl enable minecraft

# Start the service now
sudo systemctl start minecraft