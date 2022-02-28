#!/bin/bash
# environments setup

# For installing nodejs v14:
# curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
# For installing wasm pack:
# curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh



check_node_tools_installed() {
    echo "Check if $1 is installed by node ..."
    if [ ! -f "`which $1`" ]; then
        echo "$1 not found, perform install"
        sudo npm install -g $1
    fi

    if [ -f "`which $1`" ]; then
        echo "$1 is ready ✅"
    else
        echo "$1 install failed ❌, please install it manually."
    fi
}

check_rustup_installed() {
    echo "Check if rustup is installed ..."
    if [ ! -f "`which rustup`" ]; then
        echo "rustup not found, perform install";
        curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh;
        . $HOME/.cargo/env;
    fi

    if [ -f "`which rustup`" ]; then
        echo "rustup is ready ✅"
    else
        echo "rustup install failed ❌, please install it manually."
    fi
}

check_circom_installed() {
    echo "Check if circom is installed ..."
    if [ ! -f "`which circom`" ]; then
        echo "circom not found, perform install"
        git clone https://github.com/iden3/circom.git
        cd circom
        cargo build --release
        cargo install --path circom
        cd ..
    fi

    if [ -f "`which circom`" ]; then
        echo "circom is ready ✅"
    else
        echo "circom install failed ❌, please install it manually."
    fi
}

echo "Prepare environment ..."

echo "1>. Create environment.tmp folder."
[ -d "./environment.tmp" ] || mkdir environment.tmp

echo "2>. Install build tools ..."
cd environment.tmp
# in cn , first update apt
sudo apt install build-essential
sudo apt install m4 python  cmake repo 
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
echo "2.11>. nodejs-ok."
# repo npm
check_rustup_installed
check_circom_installed
echo "2.12>. circom-ok."
check_node_tools_installed snarkjs
echo "2.13>. snarkjs-ok."
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
echo "2.14>. wasm-pack-ok."
echo "3>. Cleanup environment.tmp folder."
cd .. 
[ -d "./environment.tmp" ] && rm -rf environment.tmp
echo "Environment is setup successfully. 💯"
