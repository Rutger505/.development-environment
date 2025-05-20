#!/bin/bash
curl -L "https://discord.com/api/download?platform=linux&format=deb" -o discord.deb
sudo apt install ./discord.deb
sudo rm ./discord.deb

