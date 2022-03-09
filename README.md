# delphinus-lerna
[![CI to Verify setup.sh](https://github.com/ZhenXunGe/delphinus-lerna/actions/workflows/main.yml/badge.svg)](https://github.com/ZhenXunGe/delphinus-lerna/actions/workflows/main.yml)

## Prepare Environment

For fresh environment, 
- run `> bash environment_mac.sh` for Mac or 
- run `> bash environment_linux.sh` for Linux.

If you see some error messages, need manually install the error module in your OS.

## Package Setup

After finish install the environment, please open a new terminal to continue. Then
- run `> bash setup.sh`

All done!
All delphinus packages are in packages directory.


## Deploying the Delphinus Substrate Node

From the delphinus-lerna directory, execute the deploy script  
`bash deploy.sh`  
to start the process for deploying a substrate node.  

For this script to run successfully, ensure that `Dockerfile` and `docker-compose.yaml` are in the `packages/substrate-node` directory.

The script will first build the docker image which may take up to a few minutes to complete. 
If you encounter any errors during the docker image build process, some things to check are:
    - Ensure delphinus-lerna environment is setup properly as there are several common packages required.
    - Check relative paths of the `Dockerfile` in relation to the `deploy.sh` script.

Once the docker image successfully builds, the script will execute `docker-compose` on the `docker-compose.yaml` file.

If successful the node should be operational and you should be able to see the logs of blocks being submitted, block hashes etc.


