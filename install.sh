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

[[ -z `xcode-select -p` ]] && xcode-select --install
[[ -z `which brew` ]] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
echo "Add the DNS servers 192.168.123.9 192.168.123.8 to your dns server setting in the network tab"
echo "Settings > Network > Network Interface (Wi-Fi) > Advanced > DNS "
echo "Install Complete THX for installing"

#git clone https://github.com/AdguardTeam/dnsproxy
