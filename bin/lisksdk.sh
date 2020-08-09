#!/bin/bash

echo "Installing Node as $(whoami), Home: $HOME"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install 12.15.0

npm install pm2 -g
npm install --global --production lisk-commander

echo $1 | sudo -S ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/node" "/usr/local/bin/node"
echo $1 | sudo -S ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/npm" "/usr/local/bin/npm"
echo $1 | sudo -S ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/lisk" "/usr/local/bin/lisk"
