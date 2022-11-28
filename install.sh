#!/usr/bin/env bash

# Zkontrolujeme, zda je skript spuštěn jako root
if [[ $EUID -ne 0 ]]; then
  clear
  echo "Nemáte oprávnění spustit tento skript jako uživatel Prosím použijte sudo ./install.sh" 2>&1
  exit 1
fi
clear
printf "Instalační skript pro weakOS\n"
printf "============================\n\n"
printf "Tento skript nainstaluje programy a nastavení tak jak je mám rád\n\n"
sleep 2

echo "max_parallel_downloads=10" | tee -a /etc/dnf/dnf.conf
echo "fastestmirror=True" | tee -a /etc/dnf/dnf.conf
echo "QT_QPA_PLATFORMTHEME=qt5ct" | sudo tee -a /etc/environment

clear

# Instalace Programů
printf "Instalace programů\n"
printf "=============================\n\n"

dnf -y copr enable frostyx/qtile
rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo

dnf -y install $(cat packages)

clear
printf "Instalace Fontů\n"
printf "===============\n\n"
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# Aktivace přihlašovací obrazovky
systemctl enable sddm
systemctl set-default graphical.target
clear

clear
printf "Kopíruji Konfigurační soubory\n"
printf "=============================\n\n"
sleep 5

cp -r dotfiles/. /home/$SUDO_USER/
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/
clear
sleep 5
gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
# Hotovo
sleep 10
clear
printf "Instalace weakOSu je hotová. Po restartu se projeví změny\n"
printf "=========================================================\n\n"

