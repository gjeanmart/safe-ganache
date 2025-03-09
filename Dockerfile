FROM node:20.3.0

WORKDIR /usr/src/app

COPY . /usr/src/app
COPY ./entrypoint.sh /usr/local/bin

RUN yarn install --non-interactive --frozen-lockfile

# ENVIRONMENT VARIABLES with default values
ENV DB="/db"
ENV MNEMONIC="test test test test test test test test test test test junk"
ENV RPC_PORT=8545
ENV CHAIN_ID=1337
ENV DETERMINISTIC_DEPLOYMENT="true"
ENV GANACHE_EXTRA_ARGS=""

# RUN
ENTRYPOINT ["/bin/sh", "/usr/local/bin/entrypoint.sh"]