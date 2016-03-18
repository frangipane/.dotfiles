## install vagrant to manage virtualbox

## if vagrant is already installed, skip installation
vagrant --version &> /dev/null
[ $? -eq 0 ] && return

wget https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb -O ~/Downloads/vagrant.deb

sudo dpkg -i ~/Downloads/vagrant.deb

## If you see an error with guest-additions (manifested with problems
## with syncing folders between host and guest), i.e. “GuestAdditions
## versions on your host (5.0.14) and guest (4.2.0) do not match”
## (https://github.com/dotless-de/vagrant-vbguest)
vagrant plugin install vagrant-vbguest
vagrant reload

## (optional) add vagrant box running ubuntu 12.04
# vagrant box add precise32 http://files.vagrantup.com/precise32.box

## (optional) add vagrant box running ubuntu 14.04, with Caffe deep learning framework pre-installed
# vagrant box add malthejorgensen/caffe-deeplearning
