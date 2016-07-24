## If docker is already installed, skip installation
docker version &> /dev/null
[ $? -eq 0 ] && return

## https://docs.docker.com/engine/installation/linux/ubuntulinux/


## 1. UPDATE APT SOURCES

## update package info, ensure APT works with https method, and CA
## certificates are installed
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates

## Add new GPG key
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

## Add entry for Ubuntu Trusty sources in /etc/apt/sources.list.d/docker.list
APT_PATH="/etc/apt/sources.list.d"
if [ ! -f "$APT_PATH/docker.list" ]; then
   sudo sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > "$APT_PATH/docker.list"'
fi

## Update the APT package index
sudo apt-get update

## Purge the old repo if it exists
sudo apt-get purge lxc-docker

## Verify that APT is pulling from the right repo
apt-cache policy docker-engine

##===========================================================================
## 2. PREREQS

## Install recommended linux-image-extra kernel package (allows you to
## use the aufs storage driver).
## apparmor is also required.

sudo apt-get install linux-image-extra$(uname -r)
sudo apt-get install apparmor


##===========================================================================
## 3. INSTALL DOCKER

sudo apt-get update
sudo apt-get install docker-engine
