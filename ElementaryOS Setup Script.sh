#!/bin/bash
# Start of Function Cluster
clear
tput setaf 3
echo "Initializing functions..."
sleep 1.5
tput setaf 10
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
echo "Loaded checkcompatibility."
checkfreespace () {
	min_free_space=40
	free_space=$(df -h / | awk 'NR==2{print $4}' | sed 's/[^0-9.]//g')
	if [ $(echo "$free_space < $min_free_space" | bc) -eq 1 ]; then
		spacewarning
	fi
}
echo "Loaded checkfreespace."
spacewarning () {
	clear
	tput setaf 9
	echo "The script has detected that there is less than 40 GB of storage available on the root volume."
	tput setaf 3
	echo "For an ideal experience, it is recommended that the root volume has at least 40 GB of space available."
	tput setaf 10
	echo "Your current free space: $free_space GB"
	tput setaf 3
	echo "Press <return> to continue at your own risk (for re-running the script)"
	echo "Press any other key to quit"
	tput sgr0
	echo "Enter your selection:"
	IFS=""
	read -sN1 answer
	case $(echo "$answer" | tr A-Z a-z) in
		"")	mainmenu;;
		*)	quitscript;;
	esac
}
echo "Loaded spacewarning."
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
echo "Loaded sysreqfail."
mainmenu () {
	clear
 	tput setaf 3
	echo "======================================="
	echo " --- ElementaryOS Setup Script 5.6 ---"
	echo "======================================="
	echo "Supported ElementaryOS Versions (x86_64): 6"
	echo "Recommended Free Space: 40 GB"
	tput setaf 10
	echo "Your current distro is $PRETTY_NAME."
	echo "Your current ElementaryOS version is $VERSION_ID."
	echo "Your current OS architecture is $kernelarch."
	echo "Your current free space: $free_space GB"
	tput setaf 3
	echo "Script may prompt you or ask you for your password once in a while. Please monitor your computer until the script is done."
	echo "This script will show terminal output. This is normal."
	echo "You can open this script in a text editor to view all functions."
	tput setaf 10
	echo "You are encouraged to modify this script for your own needs."
	tput setaf 9
	echo "System will automatically reboot after the script is run!!!"
	tput setaf 10
	echo "Please run this script again after a major system upgrade."
	tput setaf 9
	echo "Make sure you have a stable and fast Internet connection before proceeding!!!"
	tput setaf 3
	echo "Press 1 to perform a Full Install (All User Packages)"
	echo "Press 2 to perform a Minimal Install (Essentials)"
	echo "Press 3 to view instructions for setting up a multi-user system"
	tput setaf 9
	echo "Press Q to quit"
	tput sgr0
	echo "Enter your selection:"
	IFS=""
	read -sN1 answer
	case $(echo "$answer" | tr A-Z a-z) in
		1)	full;;
		2)	minimal;;
		3)	multiusermenu;;
		q)	quitscript;;
		*)	badoption;;
	esac
}
echo "Loaded mainmenu."
multiusermenu () {
	clear
 	tput setaf 3
	echo "==========================================="
	echo " --- Instructions for Multi-User Setup ---"
	echo "==========================================="
	tput setaf 9
	echo "If you want to set up multiple user accounts on your computer, please run the script again with the same options on each new user account. Make sure that additional user accounts are set to Administrator. You can set accounts back to Standard after completing setup."
	tput sgr0
	echo "Hit any key to return to the main menu:"
	IFS=""
	read -sN1 answer
	mainmenu
}
echo "Loaded multiusermenu."
quitscript () {
	tput sgr0
	clear
	exit
}
echo "Loaded quitscript."
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
echo "Loaded badoption."
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
echo "Loaded finish."
full () {
	clear
	tput setaf 3
	echo "Full Install/All User Packages..."
	tput sgr0
	sleep 3
	clear
	common
	runcheck sudo apt install -y ubuntu-restricted-extras synaptic remmina bleachbit frozen-bubble musescore3 asunder brasero k3b pavucontrol pulseeffects rhythmbox shotwell solaar gparted vlc p7zip-full p7zip-rar lame gpart grub2-common neofetch ffmpeg webhttrack lsp-plugins tree telegram-desktop easytag android-tools-adb android-tools-fastboot gnome-sound-recorder nikwi supertux dconf-editor deja-dup ffmpegthumbs fonts-cantarell krita gimp htop curl git handbrake gtk-3-examples menulibre python3-pip firefox gnome-disk-utility dkms gcc make linux-headers-$(uname -r) gnome-system-monitor cpu-x hardinfo gucharmap baobab bijiben supertuxkart unzip mcomix gscan2pdf gsmartcontrol
	runcheck sudo dpkg --add-architecture i386
	runcheck sudo apt update -y
	runcheck sudo apt install -y libc6-i386 libx11-6:i386 libegl1-mesa:i386 zlib1g:i386 libstdc++6:i386 libgl1-mesa-dri:i386 libasound2:i386 libpulse0:i386
	runcheck sudo apt install -y openjdk-17-jdk
	java -version
	sleep 3
	runcheck sudo add-apt-repository -y ppa:mkusb/ppa
	runcheck sudo apt install -y mkusb mkusb-nox usb-pack-efi gparted
	runcheck sudo add-apt-repository -y ppa:obsproject/obs-studio
	runcheck sudo apt install -y obs-studio
	runcheck sudo apt update -y
	runcheck sudo apt full-upgrade -y --allow-downgrades
	runcheck sudo apt autoremove -y --purge
	runcheck sudo apt autoclean -y
	flatpakmenu
	runcheck flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	runcheck flatpak update -y
	runcheck flatpak install -y flathub org.audacityteam.Audacity
	runcheck flatpak install -y flathub org.shotcut.Shotcut
	runcheck flatpak install -y flathub net.minetest.Minetest
	runcheck flatpak install -y flathub org.libreoffice.LibreOffice
	runcheck flatpak install -y appcenter com.github.donadigo.eddy
	runcheck flatpak install -y appcenter com.github.sgpthomas.hourglass
	runcheck flatpak install -y flathub org.inkscape.Inkscape
	runcheck flatpak install -y flathub ar.xjuan.Cambalache
	runcheck flatpak install -y flathub com.github.jeromerobert.pdfarranger
	runcheck flatpak install -y flathub com.github.muriloventuroso.pdftricks
	runcheck flatpak install -y flathub org.kde.okular
	runcheck flatpak install -y flathub com.github.flxzt.rnote
	runcheck flatpak install -y flathub com.github.tchx84.Flatseal
	runcheck flatpak install -y flathub com.wps.Office
	runcheck flatpak install -y flathub app.drey.EarTag
	runcheck flatpak install -y flathub de.haeckerfelix.Fragments
	runcheck flatpak install -y flathub com.calibre_ebook.calibre
	runcheck flatpak install -y flathub org.kde.kid3
	runcheck flatpak install flathub -y org.kde.subtitlecomposer
	runcheck flatpak update -y
	runcheck flatpak uninstall -y --unused --delete-data
	runcheck python3 -m pip install pip wheel youtube-dl yt-dlp speedtest-cli mangadex-downloader[optional] animdl -U
	runcheck python3 -m pip cache purge
	echo "Adding current user to cdrom group..."
	runcheck sudo usermod -aG cdrom $USER
	echo "Patching LSP icons..."
	# The next command makes sure the directory exists. It is normal for it to fail. Runcheck is not needed here. 
	mkdir ~/.local/share/applications
	runcheck echo "[Desktop Entry]
	Hidden=true" > /tmp/1
	runcheck find /usr -name "*lsp_plug*desktop" 2>/dev/null | cut -f 5 -d '/' | xargs -I {} cp /tmp/1 ~/.local/share/applications/{}
	addindicatorsupport
	autofontinstall
	finish
}
echo "Loaded full."
minimal () {
	clear
	tput setaf 3
	echo "Minimal Install/Essentials..."
	tput sgr0
	sleep 3
	clear
	common
	runcheck sudo apt install -y ubuntu-restricted-extras synaptic pavucontrol rhythmbox gparted p7zip-full p7zip-rar gpart ffmpeg dconf-editor deja-dup ffmpegthumbs fonts-cantarell htop curl git gtk-3-examples menulibre python3-pip pulseeffects firefox gnome-disk-utility dkms gcc make linux-headers-$(uname -r) gnome-system-monitor cpu-x hardinfo gucharmap baobab bijiben gscan2pdf unzip gsmartcontrol
	runcheck sudo dpkg --add-architecture i386
	runcheck sudo apt update -y
	runcheck sudo apt install -y libc6-i386 libx11-6:i386 libegl1-mesa:i386 zlib1g:i386 libstdc++6:i386 libgl1-mesa-dri:i386 libasound2:i386 libpulse0:i386
	runcheck sudo apt update -y
	runcheck sudo apt full-upgrade -y --allow-downgrades
	runcheck sudo apt autoremove -y --purge
	runcheck sudo apt autoclean -y
	flatpakmenu
	runcheck flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	runcheck flatpak update -y
	runcheck flatpak install -y flathub org.libreoffice.LibreOffice
	runcheck flatpak install -y appcenter com.github.donadigo.eddy
	runcheck flatpak install -y appcenter com.github.sgpthomas.hourglass
	runcheck flatpak install -y flathub com.github.jeromerobert.pdfarranger
	runcheck flatpak install -y flathub com.github.muriloventuroso.pdftricks
	runcheck flatpak install -y flathub org.kde.okular
	runcheck flatpak install -y flathub com.github.tchx84.Flatseal
	runcheck flatpak install -y flathub com.wps.Office
	runcheck flatpak update -y
	runcheck flatpak uninstall -y --unused --delete-data
	runcheck python3 -m pip install pip wheel speedtest-cli -U
	runcheck python3 -m pip cache purge
	echo "Patching LSP icons..."
	# The next command makes sure the directory exists. It is normal for it to fail. 
	mkdir ~/.local/share/applications
	runcheck echo "[Desktop Entry]
	Hidden=true" > /tmp/1
	runcheck find /usr -name "*lsp_plug*desktop" 2>/dev/null | cut -f 5 -d '/' | xargs -I {} cp /tmp/1 ~/.local/share/applications/{}
	addindicatorsupport
	autofontinstall
	finish
}
echo "Loaded minimal."
common () {
	runcheck sudo apt update -y
	runcheck sudo apt install -y software-properties-common
	runcheck sudo apt update -y
	runcheck sudo apt install -y gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-plugins-good libavcodec-extra gstreamer1.0-libav chromium-codecs-ffmpeg-extra libdvd-pkg libheif1 libheif-examples libquicktime2 heif-gdk-pixbuf heif-thumbnailer
	runcheck sudo dpkg-reconfigure libdvd-pkg
}
echo "Loaded common."
flatpakmenu () {
	clear
 	tput setaf 3
	echo "=============================="
	echo " --- Flatpak Instructions ---"
	echo "=============================="
	echo "When you are prompted to choose between 0-2 (Abort, System, or User), please choose 1 or 2 depending on if you want to install the application to the system or specifically to your user account."
	echo "When you are prompted to choose a branch (master, stable), please choose stable."
	tput sgr0
	echo "Press any key to continue"
	IFS=""
	read -sN1 answer
	clear
}
echo "Loaded flatpakmenu."
autofontinstall () {
	echo "Installing the Essential Font Pack..."
	runcheck sudo wget -O "/tmp/fontinstall.zip" "https://github.com/TechnologyMan101/script-extras/releases/download/20221012-1521/Essential.Font.Pack.zip"
	runcheck sudo unzip -o "/tmp/fontinstall.zip" -d "/usr/share/fonts"
	runcheck sudo chmod -R 755 "/usr/share/fonts/Essential Font Pack"
	runcheck sudo rm "/tmp/fontinstall.zip"
}
echo "Loaded autofontinstall."
addindicatorsupport () {
	echo "Adding app indicator support..."
	runcheck sudo add-apt-repository -y ppa:yunnxx/elementary
	runcheck sudo apt install -y indicator-application wingpanel-indicator-ayatana
	# Although the next 2 commands are important operations, they are not passed through runcheck in case the user decides to run the script again. Runcheck would be triggered on a second run of the script due to the files already being modified, resulting in the operations failing.
	sudo sed -i 's/OnlyShowIn=Unity;GNOME;.*/OnlyShowIn=Unity;GNOME;Pantheon;/g' /etc/xdg/autostart/indicator-application.desktop
	sudo mv /etc/xdg/autostart/nm-applet.desktop /etc/xdg/autostart/nm-applet.old
}
echo "Loaded addindicatorsupport."
runcheck () {
	IFS=$'\n'
	command="$*"
	retval=1
	attempt=1
	until [[ $retval -eq 0 ]] || [[ $attempt -gt 5 ]]; do
		(
			set +e
			$command
		)
		retval=$?
		attempt=$(( $attempt + 1 ))
		if [[ $retval -ne 0 ]]; then
			clear
			tput setaf 9
			echo "Oops! Something went wrong! Retrying in 3 seconds..."
			tput sgr0
			sleep 3
			clear
		fi
	done
	if [[ $retval -ne 0 ]] && [[ $attempt -gt 5 ]]; then
		clear
		tput setaf 9
		echo "Oops! A fatal error has occurred and the program cannot continue. Returning to the main menu in 10 seconds..."
		tput setaf 3
		echo "Please try again later or if the problem persists, create an issue on GitHub."
		tput sgr0
		sleep 10
		clear
		mainmenu
	fi
	IFS=""
}
echo "Loaded runcheck."
tput setaf 3
echo "Continuing..."
tput sgr0
sleep 1.5
# End of Function Cluster
# Start of Main Script
while true
do
	checkcompatibility
	checkfreespace
	mainmenu
done
# End of Main Script
