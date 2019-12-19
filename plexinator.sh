#!/bin/bash

# A script for auto-updating Plex Media Server (Ubuntu)

# VARIABLES
#########################

NEW="$(curl "https://plex.tv/downloads/latest/1?channel=16&build=linux-ubuntu-x86_64&distro=ubuntu" 2> /dev/null | cut -d "/" -f5  | cut -d "-" -f1)"
CURRENT="$(dpkg -l | grep plexmediaserver | awk '{print $3}' | awk -F'[ -]' '{print $1}')"
LOGPATH=/var/log/plexinator
LOG=plexinator.log
PLEX="https://plex.tv/downloads/latest/1?channel=16&build=linux-ubuntu-x86_64&distro=ubuntu&X-Plex-Token=removed"

mkdir -p /var/log/plexinator

# PERFORM CLEANUP FIRST
sudo rm /tmp/plex*

# GETTING STARTED 
clear
echo ""
echo "----------------------------------------------"
echo ""
echo "            WELCOME TO PLEXINATOR"
echo ""
echo "----------------------------------------------"
echo ""
echo ""
#echo "                   ______ "
#echo "                   \     \ "
#echo "                    \     \ "
#echo "                     \     \ "
#echo "                     /     / "
#echo "                    /     / "
#echo "                   /_____/ "
#echo ""
#echo ""
#sleep 3

# END USER CAN CHOOSE ASCII ART
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "           =======   == "
echo "          /==////== /== "
echo "          /==   /== /==   =====   ==   == "
echo "          /=======  /==  ==///== //== == "
echo "          /==////   /== /=======  //=== "
echo "          /==       /== /==////    ==/== "
echo "          /==       /== //======  == //== "
echo "          //        //   /////   //   // "
echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
sleep 4
# Grab the latest for comparison and install if newer

echo "Getting info on new version of Plex..."
echo ""
sleep 2

echo "Comparing versions..."
echo ""
sleep 2

echo "Current version is ${CURRENT}"
echo ""
sleep 3

echo "Latest version is ${NEW}"
echo ""
sleep 3

dpkg --compare-versions $NEW gt $CURRENT
sleep 3

if [ ${NEW} != ${CURRENT} ]
then
        echo "Version $NEW available for install!"
        echo ""
        echo "Grabbing version $NEW..."
        echo ""
        wget -O /tmp/plexmediaserver.deb "${PLEX}"
        echo ""
        echo "Installing version $NEW..."
        echo ""
        sudo dpkg -i /tmp/plexmediaserver.deb
        echo ""
else
        echo ""
        echo "Version $CURRENT is up to date..."
        echo ""
fi

echo ""
echo "ALL DONE!"
sleep 3
clear

