#!/bin/bash

besu \
  --data-path=/app/config/Node-1/data \
  --genesis-file=/app/config/genesis.json \
  --rpc-http-api=ETH,NET,WEB3,QBFT,ADMIN,DEBUG,MINER,TXPOOL \
  --host-allowlist="*" \
  --profile=ENTERPRISE \
  --rpc-http-enabled \
  --rpc-http-host=0.0.0.0 \
  --rpc-http-port=8545 \
  --p2p-port=30303 \
  --miner-enabled \
  --miner-coinbase=0x627306090abaB3A6e1400e9345bC60c78a8BEf57 \
  --metrics-enabled \
  --metrics-host=0.0.0.0 \
  --metrics-port=9545 \
  --logging=INFO \
  --min-gas-price=0 \
  --data-storage-format=BONSAI \
  --bonsai-historical-block-limit=512 \
  --bonsai-trie-logs-pruning-window-size=5000


until curl -s -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"net_listening","params":[],"id":1}' http://besu-node1:8545 | grep -q '"result":true'; do
  echo "Aguardando besu-node1 ficar disponível..."
  sleep 2
done

enode=$(curl -s -X POST \
  --data '{"jsonrpc":"2.0","method":"admin_nodeInfo","params":[],"id":1}' \
  -H "Content-Type: application/json" \
  http://localhost:8545 | jq -r .result.enode)

echo "acesso ao enode do no 1: $enode"

