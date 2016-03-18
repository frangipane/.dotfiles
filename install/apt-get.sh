
APT_PATH="/etc/apt/sources.list.d"
SRC_LIST="official-source-repositories.list"

## Enable/define official source code repositories if distributor is LinuxMint
if [ -n "$(echo $(lsb_release -i) | grep "LinuxMint")" ]; then

    CODENAME_MINT="$(lsb_release -sc)"
    #echo $CODENAME_MINT #e.g. rosa

    CODENAME_UBUNTU="$(echo $(lsb_release -uc) | awk -F' ' '{print $2}')"
    #echo $CODENAME_UBUNTU #e.g. trusty

    ## if apt-get src list already exists, then back it up before overwriting
    if [ -s "$APT_PATH/$SRC_LIST" ]; then
	mv "$APT_PATH/$SRC_LIST" "$APT_PATH/$SRC_LIST.backup"
    fi
       
    cat <<EOF > "$APT_PATH/$SRC_LIST"
deb-src http://packages.linuxmint.com $CODENAME_MINT main upstream import

deb-src http://extra.linuxmint.com $CODENAME_MINT main

deb-src http://archive.ubuntu.com/ubuntu $CODENAME_UBUNTU main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu $CODENAME_UBUNTU-updates main restricted universe multiverse

deb-src http://security.ubuntu.com/ubuntu/ $CODENAME_UBUNTU-security main restricted universe multiv$
deb-src http://archive.canonical.com/ubuntu/ $CODENAME_UBUNTU partner
EOF

    ## add virtualbox repo to receive future updates through software updater/package manager
    sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $CODENAME_UBUNTU contrib" > "$APT_PATH/virtualbox.list"'

    ## Also download and insert the keyring so that Ubuntu trusts the package from that repository:
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
fi


## install packages

apps=(
    tree
    imagemagick
    build-essential
    pandoc
    automake
    texlive-full
    virtualbox-5.0
    dkms # ensure that the VirtualBox host kernel modules (vboxdrv, vboxnetflt and vboxnetadp) are properly updated if the linux kernel version changes during the next apt-get upgrade
)

sudo apt-get update
sudo apt-get install "${apps[@]}"

