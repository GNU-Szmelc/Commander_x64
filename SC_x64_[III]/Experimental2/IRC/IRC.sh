#!/bin/bash

sudo apt install hexchat

# Script to automate HexChat connection to IRC server
# Set IRC server and parameters
# AUTO IRC - IRS prototype protocol script

figlet IRC-64 CLIENT | lolcat -a -d 15 -s 69 -p 1 -F 0.1

SERVER="irc.quakenet.org"
PORT="6667"
NICKNAME="ENTER_NICKNAME"
USERNAME="ENTER_USERNAME"

# Start HexChat and connect to IRC server
hexchat --command=/SERVER "irc.quakenet.org" &
#hexchat --command=/NICK $USERNAME 
#hexchat --command=/JOIN "#szmelc"

figlet IRC-64 | lolcat -a -d 15 -s 69 -p 1 -F 0.1 README.md - g

