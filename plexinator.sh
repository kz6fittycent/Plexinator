#!/bin/bash
# A script for auto-updating Plex Media Server (Ubuntu)

# VARIABLES
#########################

# Get newest Plex Version
NEW=$(curl 'https://plex.tv/downloads/latest/1?channel=16&build=linux-ubuntu-x86_64&distro=ubuntu' | cut -d '/' -f5 | cut -d '-' -f1)

# Set Current Installed Version
CURRENT="$(dpkg -l | grep plexmediaserver | awk '{print $3}' | awk -F'[ -]' '{print $1}')"

# Set Log Path
LOGPATH=~/plexinator # Future use
LOG=plexinator.log # Future use

# Plex URL
PLEX="https://plex.tv/downloads/latest/1?channel=16&build=linux-ubuntu-x86_64&distro=ubuntu&X-Plex-Token=removed"

# Filename
DEB=/tmp/plexmediaserver.deb

# PERFORM CLEANUP FIRST
rm /tmp/plex*

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
echo "                   ______ "
echo "                   \     \ "
echo "                    \     \ "
echo "                     \     \ "
echo "                     /     / "
echo "                    /     / "
echo "                   /_____/ "
echo ""
echo ""
sleep 3

# END USER CAN CHOOSE ASCII ART

#echo "           =======   == "
#echo "          /==////== /== "
#echo "          /==   /== /==   =====   ==   == "
#echo "          /=======  /==  ==///== //== == "
#echo "          /==////   /== /=======  //=== "
#echo "          /==       /== /==////    ==/== "
#echo "          /==       /== //======  == //== "
#echo "          //        //   /////   //   // "
#sleep 4
#echo ""
#echo ""



# Compare versions and install if newer

echo "Comparing versions..."
echo ""
sleep 2

echo "Current version is $CURRENT"
echo ""
sleep 1

echo "Latest version is $NEW"
echo ""
sleep 1

dpkg --compare-versions $NEW gt $CURRENT
sleep 3

if [ ${NEW} != ${CURRENT} ]
then
        echo "Version $NEW available for install!"
        echo ""
        echo "Downloading new version of Plex..."
        echo ""
        wget -O ${DEB} "${PLEX}"
        echo "Installing version $NEW..."
        echo ""
        sudo dpkg -i $DEB
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
