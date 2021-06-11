#!/bin/bash
SHELL=/bin/bash
DOMAIN='dev.ctptech.vpn'
WORKING_DIR=$HOME/$SERVICE.build
SERVICE="$DOMAIN.mDNSResponder.startup"
SERVICE_FILE="$SERVICE.plist"
BINARY_FILE='dns-server'
MANAGER_FILE='dns-manager'
GVM_RC="[[ -s "$HOME/.gvm/scripts/gvm" ]] && source $HOME/.gvm/scripts/gvm"
GIT_URL='https://github.com/charlieporth1/dev.ctptech.vpn.OSX.QUIC_DNS_SERVICE_INSTALL'

echo "Creating DIR $WORKING_DIR"
if [[ ! -d $WORKING_DIR ]]; then
	 mkdir $WORKING_DIR
else
	 rm -rf $WORKING_DIR
	 mkdir $WORKING_DIR
fi

echo "Entering DIR $WORKING_DIR"
cd $WORKING_DIR

echo "Entered DIR $WORKING_DIR:: $PWD"
echo "Cloning install files to $WORKING_DIR"
git clone $GIT_URL

mv $WORKING_DIR/dev.ctptech.vpn.OSX.QUIC_DNS_SERVICE_INSTALL/* $WORKING_DIR
source $WORKING_DIR/$MANAGER_FILE

INSTALL
INSTALL_GO
INSTALL_DNS_BINARY

cp -rf $WORKING_DIR/$SERVICE_FILE /Library/LaunchDaemons/$SERVICE_FILE
cp -rf $WORKING_DIR/$MANAGER_FILE /usr/local/bin/$MANAGER_FILE
cp -rf $WORKING_DIR/$BINARY_FILE /usr/local/bin/$BINARY_FILE

chmod 777 /usr/local/bin/$MANAGER_FILE
chmod 777 /usr/local/bin/$BINARY_FILE

source /usr/local/bin/$MANAGER_FILE

RESTART_DNS
RETRY_RESTART
networksetup -setdnsservers WiFi 192.168.123.9 192.168.123.8 174.53.130.17
networksetup -setdnsservers Ethernet 192.168.123.9 192.168.123.8 174.53.130.17
echo "Add the DNS servers 192.168.123.9 192.168.123.8 to your dns server setting in the network tab"
echo "Settings > Network > Network Interface (Wi-Fi) > Advanced > DNS "
echo "Install Complete THX for installing"

