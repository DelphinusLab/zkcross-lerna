#!/bin/bash
# environments setup

check_cmake_installed() {
    echo "Check if cmake is installed ..."
    if [ ! -f "`which cmake`" ]; then
        echo "cmake not found, perform install"
        sudo apt install cmake
    fi

    if [ -f "`which cmake`" ]; then
        echo "cmake is ready ✅"
    else
        echo "cmake install failed ❌, please install it manually."
    fi
}

check_m4_installed() {
    echo "Check if m4 is installed ..."
    if [ ! -f "`which m4`" ]; then
        echo "m4 not found, perform install"
        sudo apt install m4
    fi

    if [ -f "`which m4`" ]; then
        echo "m4 is ready ✅"
    else
        echo "m4 install failed ❌, please install it manually."
    fi
}

check_npm_installed() {
    echo "Check if npm is installed ..."
    if [ ! -f "`which npm`" ]; then
        echo "npm not found, perform install"
        sudo apt install npm
    fi

    if [ -f "`which npm`" ]; then
        echo "npm is ready ✅"
    else
        echo "npm install failed ❌, please install it manually."
    fi
}

check_repo_installed() {
    echo "Check if repo is installed ..."
    if [ ! -f "`which repo`" ]; then
        echo "repo not found, perform install"
        mkdir -p ~/.bin
        PATH="${HOME}/.bin:${PATH}"
        curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
        chmod a+rx ~/.bin/repo
    fi

    if [ -f "`which repo`" ]; then
        echo "repo is ready ✅"
    else
        echo "repo install failed ❌, please install it manually."
    fi
}

check_nodejs_installed() {
    echo "Check if nodejs is installed ..."
    if [ ! -f "`which nodejs`" ]; then
        echo "nodejs not found, perform install";
        curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash - &&\
        sudo apt-get install -y nodejs
    fi

    if [ -f "`which nodejs`" ]; then
        echo "nodejs is ready ✅"
    else
        echo "nodejs install failed ❌, please install it manually."
    fi
}

check_node_tools_installed() {
    echo "Check if npm/node is installed ..."
    if [ ! -f "`which npm`" ]; then
        echo "npm not found, perform install"
        sudo apt install npm
    fi

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

check_wasm-pack_installed() {
    echo "Check if wasm-pack is installed ..."
    if [ ! -f "`which wasm-pack`" ]; then
	echo "wasm-pack not found, perform install";
	curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
    fi

    if [ -f "`which wasm-pack`" ]; then
        echo "wasm-pack is ready ✅"
    else
        echo "wasm-pack install failed ❌, please install it manually."
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

check_solc_installed() {
    echo "Check if solc installed and version > 0.8.*"
    correct_version=$(solc --version | grep -w '^Version: 0.8*')

    if [[ ( ! -f "`which solc`" ) || ( -z "$correct_version" ) ]]
    then
        sudo add-apt-repository ppa:ethereum/ethereum
        sudo apt-get update
        sudo apt-get install solc
    fi

    if [ -f "`which solc`" ]; then
        echo "solc is ready ✅"
    else
        echo "solc install failed ❌, please install it manually."
    fi
}

check_docker_installed() {
    echo "Check if docker installed."

    if [[ ( ! -f "`which docker`" ) ]]
    then
        sudo apt-get update
        sudo apt-get install ca-certificates curl gnupg lsb-release
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    fi

    if [ -f "`which docker`" ]; then
        echo "docker is ready ✅"
    else
        echo "docker install failed ❌, please install it manually."
    fi
}


check_mongoDB_installed() {
    echo "Check if mongod installed."

    if [[ ( ! -f "`which mongod`" ) ]]
    then
        wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
        echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
        sudo apt-get update
        sudo apt-get install -y mongodb-org
    fi

    if [ -f "`which mongod`" ]; then
        echo "mongoDB is ready ✅"
    else
        echo "mongoDB install failed ❌, please install it manually."
    fi
}



echo "Prepare environment ..."

echo "1>. Create environment.tmp folder."
[ -d "./environment.tmp" ] || mkdir environment.tmp

echo "2>. Install build tools ..."
cd environment.tmp
sudo apt-get update
sudo apt install build-essential
sudo apt install m4 npm python
check_cmake_installed
check_solc_installed
check_docker_installed
check_mongoDB_installed
#Install m4 to avoid unnecessary repositories conflict for npm and repo
check_m4_installed
check_nodejs_installed
check_npm_installed
check_repo_installed
check_rustup_installed
check_wasm-pack_installed
check_circom_installed
check_node_tools_installed snarkjs

echo "3>. Cleanup environment.tmp folder."
cd .. 
[ -d "./environment.tmp" ] && rm -rf environment.tmp
echo "Environment is setup successfully. 💯"
