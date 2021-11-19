# ElementaryOS Setup Script
Bash script to set up a fresh install of ElementaryOS.


# Documentation

Version 4.7

Supported ElementaryOS Versions: 6.x

**Please Run Script After Following Instructions Here**

**The Extras folder also contains other tools you may want including font packs.**

Please install .deb files and files using other types of installation formats using files manually (if you have them). Please use `sudo apt install /path/to/file` to install .deb packages.

Please copy the Essential Font Pack from Extras at https://mega.nz/folder/sBwwxBTR#zf6d3UaJYnNGl5tXaN63ag into `/usr/share/fonts/` Open the file manager as an administrator. This is required to perform these actions as this is modifying files on the system level. Before copying the font pack to the fonts folder, check that the folder permissions are all on “Read, Write, Execute” for all users.

Please add yourself to `vboxusers` using `sudo usermod -aG vboxusers $USER` and then reboot. Only do this if you have VirtualBox installed.


# Keyboard Shortcuts:

Change “Toggle Fullscreen” to “Super+F11”

Refer to image for media controls on desktop keyboards.


# Run Script:

Mark the script as executable by changing it in file properties or running `chmod +x /path/to/file`. Then run it in Terminal with `bash /path/to/file`


# Media Shortcuts Image:
![Error](https://github.com/TechnologyMan101/elementaryos-setup-script/blob/main/Media%20Shortcuts%20for%20Desktop%20Keyboards.png?raw=true)


# VM Users

Minimal Install is recommended. VM Tools can be found at  https://mega.nz/folder/sBwwxBTR#zf6d3UaJYnNGl5tXaN63ag in Extras.
