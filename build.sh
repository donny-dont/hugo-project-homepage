#!/bin/sh
set -ex

# Get Dart version
dart --version

# Build the dart project
pub build

# Clone the master branch into a new directory
git clone https://github.com/donny-dont/hugo-project-homepage.git master

# Install node for processing tools
NPM_CONFIG_LOGLEVEL=info
NODE_VERSION=6.0.0

curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz"
tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1
rm "node-v$NODE_VERSION-linux-x64.tar.xz"
  
# Get Node version
node --version
npm --version
