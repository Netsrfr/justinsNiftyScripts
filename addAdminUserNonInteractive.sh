#!/bin/bash

# User defined variables
ADD_USER=''
ADD_PASS=''
ADD_KEY=''

# Do not modify past this point.
if grep -q "sudo" <<< $(getent group); then
    SUDO_GROUP='sudo'
elif grep -q "wheel" <<< $(getent group); then
    SUDO_GROUP='wheel'
else
    echo 'Sudo group not found.'
    exit 1
fi
useradd -m -p $(perl -e "print crypt($ADD_PASS, '$(openssl rand -base64 16)')") "$ADD_USER"
usermod -aG $SUDO_GROUP $ADD_USER
mkdir /home/$ADD_USER/.ssh
echo $ADD_KEY >> /home/$ADD_USER/.ssh/authorized_keys
chown -R $ADD_USER:$ADD_USER /home/$ADD_USER/.ssh
ADD_USER= ADD_PASS= ADD_KEY=