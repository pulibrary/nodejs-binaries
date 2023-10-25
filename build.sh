#!/bin/sh

# To run, pass acess token and desired version when runnging script:
# ./build.sh v16.15.1 accesstoken12345

VERSION=$1
GITHUB_TOKEN=$2
nodejs_binaries_repo

# Install newer version of gcc and g++
add-apt-repository ppa:ubuntu-toolchain-r/test
apt-get update
apt-get -y install gcc-11 g++-11
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 20
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 20
update-alternatives --set gcc "/usr/bin/gcc-11"
update-alternatives --set g++ "/usr/bin/g++-11"

# Install GitHub CLI
type -p curl >/dev/null || (apt update && apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg |
dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture)
signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg]
https://cli.github.com/packages stable main" | tee
/etc/apt/sources.list.d/github-cli.list > /dev/null \
&& apt update \
&& apt install gh -y

# Make temp directory
DIR="$(mktemp -d)"

# Download and unarchive nodejs source files
 wget https://nodejs.org/dist/$VERSION/node-$VERSION.tar.gz -P $DIR && tar -xzvf $DIR/node-$VERSION.tar.gz -C $DIR


cd $DIR
mkdir node-$VERSION-linux-x64
cd node-$VERSION
./configure
make
make install DESTDIR=$DIR PREFIX=/
