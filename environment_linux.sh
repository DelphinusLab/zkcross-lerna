#!/bin/bash
# environments setup

# For installing nodejs v14:
# curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
# For installing wasm pack:
# curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

check_brew_installed() {
    echo "Check if brew is installed ..."
    if [ ! -f "`which brew`" ]; then
        echo "brew not found, perform install"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi

    if [ -f "`which brew`" ]; then
        echo "brew is ready ✅"
    else
        echo "brew install failed ❌, please install it manually."
    fi
}

check_brew_tools_installed() {
    echo "Check if $1 is installed by brew ..."
    if [ ! -f "`which $1`" ]; then
        echo "$1 not found, perform install"
        brew install $1
    fi

    if [ -f "`which $1`" ]; then
        echo "$1 is ready ✅"
    else
        echo "$1 install failed ❌, please install it manually."
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
check_brew_installed
sudo apt-get update
sudo apt install build-essential
sudo apt install m4 npm python
check_brew_tools_installed cmake
check_solc_installed
check_docker_installed
check_mongoDB_installed
#Install m4 to avoid unnecessary repositories conflict for npm and repo
check_brew_tools_installed m4
check_brew_tools_installed npm
check_brew_tools_installed repo
check_rustup_installed
check_circom_installed
check_node_tools_installed snarkjs

echo "3>. Cleanup environment.tmp folder."
cd .. 
[ -d "./environment.tmp" ] && rm -rf environment.tmp
echo "Environment is setup successfully. 💯"
