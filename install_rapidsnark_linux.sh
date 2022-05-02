check_rapidSnark_installed() {
    echo "Check if rapidSnark is installed ..."
    if [ ! -f "../tools/rapidsnark/build/prover" ]; then
        echo "rapidSnark not found, perform install"
        [ -d "../tools" ] || mkdir ../tools
        cd ../tools
        git clone git@github.com:iden3/rapidsnark.git
        cd rapidsnark
        npm install
        git submodule init
        git submodule update
        npx task createFieldSources
        npx task buildProver
        cd ../../rapidsnark.tmp
    fi

    if [ -f "../tools/rapidsnark/build/prover" ]; then
        echo "rapidsnark is ready ✅"
    else
        echo "rapidsnark install failed ❌, please install it manually."
    fi
}

echo "1>. Create rapidsnark.tmp folder."
[ -d "./rapidsnark.tmp" ] || mkdir rapidsnark.tmp

echo "2>. Install build tools ..."
cd rapidsnark.tmp
sudo apt install build-essential
sudo apt-get install libgmp-dev
sudo apt-get install libsodium-dev
sudo apt-get install nasm
check_rapidSnark_installed

echo "3>. Cleanup rapidsnark.tmp folder."
cd .. 
[ -d "./rapidsnark.tmp" ] && rm -rf rapidsnark.tmp
echo "rapidsnark is setup successfully. 💯"