#!/bin/bash
set -e

ENODE_FILE="/app/config/Node-1/data/enode"

until [ -f "$ENODE_FILE" ]; do
  echo "Aguardando o arquivo enode do besu-node1 ser criado em $ENODE_FILE..."
  sleep 2
done

RAW_ENODE=$(cat "$ENODE_FILE")
# Substituir o IP 127.0.0.1 pelo IP real do container
# ENODE=$(echo "$RAW_ENODE" | sed 's/@127\.0\.0\.1:/@172.25.0.10:/')

echo "🧩 ENODE corrigido: $ENODE"

# Rodar o Besu com o enode do nó 1 como bootnode
exec besu \
  --data-path=/app/config/Node-4/data \
  --genesis-file=/app/config/genesis.json \
  --host-allowlist="*" \
  --p2p-port=30306 \
  --bootnodes="$ENODE" \
  --profile=ENTERPRISE \
  --miner-enabled \
  --miner-coinbase=0x627306090abaB3A6e1400e9345bC60c78a8BEf57 \
  --metrics-enabled \
  --metrics-host=0.0.0.0 \
  --metrics-port=9545 \
  --logging=WARN \
  --min-gas-price=0 \
  --rpc-http-enabled \
  --rpc-http-host=0.0.0.0 \
  --rpc-http-port=8545 \
  --data-storage-format=BONSAI \
  --bonsai-historical-block-limit=512 \
  --bonsai-trie-logs-pruning-window-size=5000
