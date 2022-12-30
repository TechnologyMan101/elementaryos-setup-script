# ElementaryOS Setup Script
Bash script to set up a fresh install of ElementaryOS.


# Documentation

Version 5.4

Supported ElementaryOS Versions: 6.x

Recommended Free Space: 40 GB

**Please Run Script After Following Instructions Here**

<ins>_**Make sure to update your system using the system’s software center and reboot before performing any tasks here and running the script. Failing to do so may result in severe breakage!!!**_</ins>

**The Extras folder also contains other tools you may want.**

Please install .deb files and files using other types of installation formats using files manually (if you have them). Please use `sudo apt install /path/to/file` to install .deb packages.

Please add yourself to `vboxusers` using `sudo usermod -aG vboxusers $USER` and then reboot. Only do this if you have VirtualBox installed. Since VirtualBox is installed as a DEB package on this distro, make sure to run it before the script and after installing VirtualBox if you choose to install VirtualBox. 


# Keyboard Shortcuts:

Change “Toggle Fullscreen” to “Super+F11”

Refer to image for media controls on desktop keyboards.


# Run Script:

Mark the script as executable by changing it in file properties or running `chmod +x /path/to/file`. Then run it in Terminal with `bash /path/to/file`


# Media Shortcuts Image:
![Error](https://github.com/TechnologyMan101/elementaryos-setup-script/blob/main/Media%20Shortcuts%20for%20Desktop%20Keyboards.png?raw=true)


# VM Users

Minimal Install is recommended. VM Tools can be found at  https://mega.nz/folder/sBwwxBTR#zf6d3UaJYnNGl5tXaN63ag in Extras.
