#!/bin/sh
# This script will allow you to check (via MAC Address) all-night-long (if you run it as such via crontab) whether or not you have a particular "internet of garbage" device online.
# Notification: It will play a sound. Want an email instead? Just program that in there in place of where I'm playing an audio file.
# Why: Say you have a crazy girlfriend who turns these devices on when you're not paying attention. AND say you're concerned about "capitulation signals" being sent out like little human slave dog whistles by EvilAmaShitzon and other overlords at 3AM. You can run this script and it will tell you if the device had been turned back ON against your will, so you can get up and turn it off. Not to mention the spying.

check_if_on()
{
mac=$1
ip=$(cat /proc/net/arp | grep $mac | awk '{print$1}')
if [ "$ip" != "" ]; then
echo "1"
fi
unset ip
unset mac
}


play_audio_file()
{
audio_files_dir=$2
file_to_play=$1
echo "Playing file... "$1
mpg123 -q ${audio_files_dir}bumpersiren.mp3
mpg123 -q $audio_files_dir$file_to_play
mpg123 -q $audio_files_dir$file_to_play
}

audio_files_dir="/home/USERNAME/scripts/EvilAmaShitzonchecker/audiofiles/"


# Flush arp
# sudo ip -s -s neigh flush all
sudo ip -s -s neigh flush all
# Ping subnet. Pinging broadcast most will not respond so use this I think to ping every IP
# nmap -T5 -sP 192.168.0.0-255 # Doesn't always work with nmap.
fping -s -g 192.168.0.15 192.168.0.100 -r 1 # This is my DHCP assigned range I'm assigning. No need to ping the entire subnet. I'm running this to fill up the arp table which we will then consult.

# My first device I don't want plugged in. Get the MAC by pinging it once from your machine and then typing arp -a. Or check your router (NAT Box) arp tables. Or reboot your nat box and just plug this EvilAmaShitzon device in so you can see its MAC.
EvilAmaShitzon_echo8="33:33:33:33:33:69"
 
default_text_on="DEVICE ON"

result=$(check_if_on $EvilAmaShitzon_echo8)
if [ "$result" = "1" ]; then echo $default_text_on && play_audio_file echo8.mp3 $audio_files_dir; fi &&unset result

 
