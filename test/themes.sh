#!/usr/bin/bash
git clone https://github.com/Adapta-Projects/Adapta-Nord
cd home/$SUDO_USER/Adapta-Nord
./Install.sh

git clone https://github.com/robertovernina/NordArc
cp -r /home/$SUDO_USER/NordArc/NordArc-Theme /usr/share/themes/
cp -r /home/$SUDO_USER/NordArc/NordArc-Icons /usr/share/icons/