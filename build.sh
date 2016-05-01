#!/bin/sh
set -ex

# Get Dart version
dart --version

# Build the dart project
pub get
pub build

# Clone the master branch into a new directory
MASTER_BRANCH=master
git clone https://github.com/donny-dont/hugo-project-homepage.git $MASTER_BRANCH

# Install node for processing tools
NPM_CONFIG_LOGLEVEL=info
NODE_VERSION=6.0.0

curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz"
tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1
rm "node-v$NODE_VERSION-linux-x64.tar.xz"
  
# Get Node version
node --version

# Build the files
npm install -g grunt-cli
npm install
grunt
grunt deploy --target=$MASTER_BRANCH

# See if the repo has changed
cd $MASTER_BRANCH
if [ -n "$(git status --porcelain)" ]; then
  echo "there are changes";
  git status
else
  echo "no changes";
fi
