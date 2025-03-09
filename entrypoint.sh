#!/bin/sh

# Change to the correct directory
cd /usr/src/app;

# Start Ganache as a background process
npx ganache-cli \
    --wallet.defaultBalance 1000  \
    --database.dbPath $DB \
    --server.host 0.0.0.0 \
    --server.port $RPC_PORT \
    --wallet.mnemonic "$MNEMONIC" \
    --chain.chainId $CHAIN_ID \
    --chain.networkId $CHAIN_ID \
    --chain.allowUnlimitedContractSize \
    --chain.allowUnlimitedInitCodeSize \
    --chain.vmErrorsOnRPCResponse \
    $GANACHE_EXTRA_ARGS &

# Wait for ganache node to initialize and then deploy contracts
npx wait-on tcp:$RPC_PORT && npx hardhat --network localhost deploy;

# The ganache node process never completes
# Waiting prevents the container from pausing
wait $!