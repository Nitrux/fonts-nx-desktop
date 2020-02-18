#!/bin/bash

apt-get --yes update
apt-get --yes install wget

### Add KDENeon Repository
echo 'deb http://archive.neon.kde.org/user bionic main' | tee /etc/apt/sources.list.d/neon.list
wget -qO - 'http://archive.neon.kde.org/public.key' | apt-key add -

### Install Dependencies
apt-get --yes update
apt-get --yes dist-upgrade
apt-get --yes install devscripts lintian build-essential automake autotools-dev equivs
mk-build-deps -i -t "apt-get --yes" -r

### Build Deb
mkdir source
mv ./* source/ # Hack for debuild
cd source
debuild -b -uc -us
