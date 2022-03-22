DOCKER_BUILDKIT=1 docker build . -t delphinus-node -f packages/substrate-node/Dockerfile
DOCKER_BUILDKIT=1 docker build . -t delphinus-prover -f packages/rapidsnark/Dockerfile
docker-compose -f docker-compose.yml up
