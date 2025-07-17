#!/bin/bash
set -e

BASE_DIR="./config"
NETWORK_DIR="${BASE_DIR}/networkFiles"
KEYS_DIR="${NETWORK_DIR}/keys"
CONFIG_FILE="./qbftConfig.json"
NUM_NOS=6
mkdir -p "$BASE_DIR"
for i in $(seq 1 "$NUM_NOS"); do
  mkdir -p "${BASE_DIR}/Node-${i}/data"
done

if [ ! -f "$CONFIG_FILE" ]; then
  echo "❌ Arquivo ${CONFIG_FILE} não encontrado."
  exit 1
fi

besu operator generate-blockchain-config \
  --config-file="$CONFIG_FILE" \
  --to="$NETWORK_DIR" \
  --private-key-file-name=key

sleep 5
i=1
for addr_dir in "${KEYS_DIR}"/*; do
  if [ -d "$addr_dir" ] && [ $i -le $NUM_NOS ]; then
    cp "$addr_dir/key" "$BASE_DIR/Node-${i}/data/key"
    cp "$addr_dir/key.pub" "$BASE_DIR/Node-${i}/data/key.pub"
    touch "$BASE_DIR/Node-${i}/data/address"
    touch "$BASE_DIR/Node-${i}/data/enode"
    besu public-key export-address --node-private-key-file="$BASE_DIR/Node-${i}/data/key" --to="$BASE_DIR/Node-${i}/data/address"

    PUBKEY=$(cat "$BASE_DIR/Node-${i}/data/key.pub")
    PUBKEY="${PUBKEY#0x}"
        IP=172.25.0.10
        PORT=$((30303 + $i - 1))
        echo "enode://${PUBKEY}@${IP}:${PORT}" > "$BASE_DIR/Node-${i}/data/enode"
    
    echo "✔️ Chave movida para Node-${i}"
    i=$((i + 1))
  fi
done

cp "${NETWORK_DIR}/genesis.json" "${BASE_DIR}/genesis.json"
rm -r "${NETWORK_DIR}"

echo "✅ Configuração finalizada com sucesso!"
