#!/bin/bash
# A script for auto-updating Plex Media Server (Ubuntu)

# VARIABLES
#########################

NEW="$(dpkg -I /tmp/plexmediaserver.deb | grep Version | awk '{print $2}' | awk -F'[ -]' '{print $1}')"
CURRENT="$(dpkg -l | grep plexmediaserver | awk '{print $3}' | awk -F'[ -]' '{print $1}')"
LOGPATH=~/plexinator
LOG=plexinator.log
PLEX="https://plex.tv/downloads/latest/1?channel=16&build=linux-ubuntu-x86_64&distro=ubuntu&X-Plex-Token=removed"
DEB=/tmp/plexmediaserver.deb

# PERFORM CLEANUP FIRST
rm /tmp/plex*

# GETTING STARTED 

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

# Grab the latest for comparison and install if newer

echo "Downloading new version of Plex..."
echo ""
wget -O ${DEB} "${PLEX}"

echo "Comparing versions..."
echo ""
sleep 2

echo "Current version is ${CURRENT}"
echo ""
sleep 3

echo "Downloaded version is ${NEW}"
echo ""
sleep 3

dpkg --compare-versions $NEW gt $CURRENT
sleep 3

if [ ${NEW} != ${CURRENT} ]
then
        echo "Version $NEW available for install!"
        echo ""
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
