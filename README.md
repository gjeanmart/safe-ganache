
## Safe x Ganache x Hardhat Docker container

A Docker container for launching a local Ethereum node using Ganache and deploying Safe's singleton contracts deterministically. This ensures contracts remain deployed across node restarts without requiring redeployment.

### Getting started

**Example with Docker**

```shell
docker run --name safe-ganache-node --rm \
-p 8545:8545 \
-e CHAIN_ID=1337 \
-ti gjeanmart/safe-ganache-node:latest
```



**Example with Docker Compose**

```yaml
  node:
    image: gjeanmart/safe-ganache-node:latest
    ports:
      - 8545:8545
    environment:
      MNEMONIC: ${MNEMONIC}
      CHAIN_ID: ${CHAIN_ID}
    volumes:
      - ./data/ganache:/db
    healthcheck:
      test: curl -sf -X POST --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' localhost:8545
      interval: 5s
      timeout: 5s
      retries: 5
```

### Environment Variables

| ENV_VAR            | default value                                               | description                                                         |
|--------------------|-------------------------------------------------------------|---------------------------------------------------------------------|
| DB                 | /db                                                         | Path to the directory where the chain database is stored |
| MNEMONIC           | test test test test test test test test test test test junk | HD wallet mnemonic for generating initial addresses |
| RPC_PORT           | 8545                                                        | Port for the RPC server |
| CHAIN_ID           | 1337                                                        | Chain ID of the network |
| GANACHE_EXTRA_ARGS |                                                             | Additional arguments for the Ganache command |


### Development

Install dependencies

```shell
$ yarn 
```

Run with Docker Compose

```shell
$ docker compose up
```