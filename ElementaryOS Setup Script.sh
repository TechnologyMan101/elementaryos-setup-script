#!/bin/bash
# Start of Function Cluster
checkcompatibility () {
	# Set variables
	. /etc/os-release
	iselementaryos="false"
	kernelarch=$(uname -m)
	
	# Check distro
	if ! echo $PRETTY_NAME | grep -qi "elementary OS"
	then
		sysreqfail
	fi
	iselementaryos="true"

	# Check for 6
	if ! echo $VERSION_ID | grep -qi "6"
	then
		sysreqfail
	fi
	
	# Check kernel architecture
	if ! uname -m | grep -qi "x86_64"
	then
		sysreqfail
	fi
}
sysreqfail () {
	clear
	tput setaf 9
	echo "System requirements not met. This script supports x86_64 versions of ElementaryOS 6!!!"
	tput setaf 3
	echo "If your error is not caused by a wrong ElementaryOS version or OS architecture, please check to see if I have published a script for your system."
	tput setaf 10
	echo "Your current distro is $PRETTY_NAME."
	# Display ElementaryOS version if ElementaryOS
	if echo $iselementaryos | grep -qi "true"
	then
		echo "Your current ElementaryOS version is $VERSION_ID."
	fi
	echo "Your current OS architecture is $kernelarch."
	tput sgr0
	echo "Hit any key to exit:"
	IFS=""
	read -sN1 answer
	quitscript
}
mainmenu () {
	clear
 	tput setaf 3
	echo "======================================="
	echo " --- ElementaryOS Setup Script 4.0 ---"
	echo "======================================="
	echo "Supported ElementaryOS Versions (x86_64): 6"
	tput setaf 10
	echo "Your current distro is $PRETTY_NAME."
	echo "Your current ElementaryOS version is $VERSION_ID."
	echo "Your current OS architecture is $kernelarch."
	tput setaf 3
	echo "Script may prompt you or ask you for your password once in a while. Please monitor your computer until the script is done."
	echo "This script will show terminal output. This is normal."
	echo "You can open this script in a text editor to see packages to be installed in detail."
	tput setaf 10
	echo "You are encouraged to modify this script for your own needs."
	tput setaf 9
	echo "System will automatically reboot after the script is run!!!"
	echo "It is not recommended to run this script more than once!!!"
	echo "Make sure you have a stable and fast Internet connection before proceeding!!!"
	tput setaf 3
	echo "Press 1 to perform a Full Install (All User Packages)"
	echo "Press 2 to perform a Minimal Install (Essentials)"
	tput setaf 9
	echo "Press Q to quit"
	tput sgr0
	echo "Enter your selection:"
	IFS=""
	read -sN1 answer
	case $(echo "$answer" | tr A-Z a-z) in
		1)	full;;
		2)	minimal;;
		q)	quitscript;;
		*)	badoption;;
	esac
}
quitscript () {
	tput sgr0
	clear
	exit
}
badoption () {
	clear
	tput setaf 9
	echo "Invalid Option!"
	tput setaf 3
	echo "Returning to Main Menu..."
	tput sgr0
	sleep 3
	mainmenu
}
finish () {
	clear
	tput setaf 10
	echo "Done..."
	tput setaf 9
	echo "Rebooting..."
	tput sgr0
	sleep 3
	clear
	sudo reboot
}
full () {
	clear
	tput setaf 3
	echo "Full Install/All User Packages..."
	tput sgr0
	sleep 3
	clear
	common
	sudo apt install -y ubuntu-restricted-extras synaptic remmina bleachbit frozen-bubble musescore3 asunder brasero k3b pavucontrol pulseeffects rhythmbox shotwell solaar gparted vlc p7zip-full p7zip-rar lame gpart grub2-common neofetch ffmpeg webhttrack lsp-plugins tree telegram-desktop easytag android-tools-adb android-tools-fastboot gnome-sound-recorder nikwi supertux dconf-editor deja-dup unoconv ffmpegthumbs fonts-cantarell gnome-books krita gimp htop transmission curl git handbrake gtk-3-examples menulibre python3-pip firefox file-roller io.elementary.contractor.file-roller
	sudo dpkg --add-architecture i386
	sudo apt update -y
	sudo apt install -y libc6-i386 libx11-6:i386 libegl1-mesa:i386 zlib1g:i386 libstdc++6:i386 libgl1-mesa-dri:i386 libasound2:i386 libpulse0:i386
	sudo add-apt-repository -y ppa:linuxuprising/java
	echo oracle-java17-installer shared/accepted-oracle-license-v1-2 select true | sudo /usr/bin/debconf-set-selections
	sudo apt install -y oracle-java17-installer --install-recommends
	java -version
	sleep 3
	sudo add-apt-repository -y ppa:mkusb/ppa
	sudo apt install -y mkusb mkusb-nox usb-pack-efi gparted
	sudo add-apt-repository -y ppa:obsproject/obs-studio
	sudo apt install -y obs-studio
	sudo apt update -y
	sudo apt full-upgrade -y --allow-downgrades
	sudo apt autoremove -y --purge
	sudo apt autoclean -y
	flatpak install -y flathub org.audacityteam.Audacity
	flatpak install -y flathub org.shotcut.Shotcut
	flatpak install -y flathub net.minetest.Minetest
	flatpak install -y flathub org.libreoffice.LibreOffice
	flatpak install -y appcenter com.github.donadigo.eddy
	flatpak install -y appcenter com.github.sgpthomas.hourglass
	flatpak install -y appcenter org.gnome.Evince
	flatpak update -y
	flatpak uninstall -y --unused --delete-data
	pip3 install pip youtube-dl yt-dlp speedtest-cli -U
	echo "Adding current user to cdrom group..."
	sudo usermod -aG cdrom $USER
	echo "Patching LSP icons..."
	mkdir ~/.local/share/applications
	echo "[Desktop Entry]
	Hidden=true" > /tmp/1
	find /usr -name "*lsp_plug*desktop" 2>/dev/null | cut -f 5 -d '/' | xargs -I {} cp /tmp/1 ~/.local/share/applications/{}
	finish
}
minimal () {
	clear
	tput setaf 3
	echo "Minimal Install/Essentials..."
	tput sgr0
	sleep 3
	clear
	common
	sudo apt install -y ubuntu-restricted-extras synaptic pavucontrol rhythmbox gparted p7zip-full p7zip-rar gpart ffmpeg dconf-editor deja-dup unoconv ffmpegthumbs fonts-cantarell htop curl git gtk-3-examples menulibre python3-pip pulseeffects firefox file-roller io.elementary.contractor.file-roller
	sudo dpkg --add-architecture i386
	sudo apt update -y
	sudo apt install -y libc6-i386 libx11-6:i386 libegl1-mesa:i386 zlib1g:i386 libstdc++6:i386 libgl1-mesa-dri:i386 libasound2:i386 libpulse0:i386
	sudo apt update -y
	sudo apt full-upgrade -y --allow-downgrades
	sudo apt autoremove -y --purge
	sudo apt autoclean -y
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak update -y
	flatpak install -y flathub org.libreoffice.LibreOffice
	flatpak install -y appcenter com.github.donadigo.eddy
	flatpak install -y appcenter com.github.sgpthomas.hourglass
	flatpak install -y appcenter org.gnome.Evince
	flatpak uninstall -y --unused --delete-data
	pip3 install pip speedtest-cli -U
	echo "Patching LSP icons..."
	mkdir ~/.local/share/applications
	echo "[Desktop Entry]
	Hidden=true" > /tmp/1
	find /usr -name "*lsp_plug*desktop" 2>/dev/null | cut -f 5 -d '/' | xargs -I {} cp /tmp/1 ~/.local/share/applications/{}
	finish
}
common () {
	sudo apt update -y
	sudo apt install -y gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-plugins-good libavcodec-extra gstreamer1.0-libav chromium-codecs-ffmpeg-extra libdvd-pkg
	sudo dpkg-reconfigure libdvd-pkg
}
# End of Function Cluster
# Start of Main Script
while true
do
	checkcompatibility
	mainmenu
done
# End of Main Script
