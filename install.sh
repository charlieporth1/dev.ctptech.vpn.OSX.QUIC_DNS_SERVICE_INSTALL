#!/bin/bash
DOMAIN=dev.ctptech.vpn
SERVICE=$DOMAIN.dns.service
WORKING_DIR=$HOME/$SERVICE.build
SERVICE_FILE=dev.ctptech.vpn.mDNSResponder.startup.plist
BINARY_FILE=dns-server
GIT_URL=https://github.com/charlieporth1/dev.ctptech.vpn.OSX.QUIC_DNS_SERVICE_INSTALL

[[ ! -d $WORKING_DIR ]] && mkdir $WORKING_DIR
cd $WORKING_DIR
git clone $GIT_URL
xcode-select -p
xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install gvm
mkdir -p $HOME/go/{bin,src}
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
gvm install go1.15.6
go get https://github.com/AdguardTeam/dnsproxy
cp -rf $WORKING_DIR/$SERVICE_FILE /Library/LaunchDaemons/$SERVICE_FILE
cp -rf $WORKING_DIR/$BINARY_FILE /usr/local/bin/$BINARY_FILE
chmod 777 /usr/local/bin/$BINARY_FILE
source /usr/local/bin/$BINARY_FILE
RESTART_DNS
echo "Install Complete THX for installing"


#git clone https://github.com/AdguardTeam/dnsproxy
