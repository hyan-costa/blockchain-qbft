# blockchain-besu



## Getting started

Para executar a rede, primeiramente baixe o binário do besu e descompacte-o para seguir os próximos passos:

[besu-25.2.1](https://github.com/hyperledger/besu/releases/download/25.2.1/besu-25.2.1.tar.gz)

## Execute o script setup.sh:

```
./setup.sh
```

## Execute o docker composer:

```
docker-compose up -d --build
```


## Porta da rede blockchain:
`8545`

# Testando a rede:


## Execute o comando abaixo (coloque o ip na requisição):
```
curl -X POST --data '{"jsonrpc":"2.0","method":"net_peerCount","params":[],"id":1}' http://<IP>:8545
```

Se a resposta for como a do json abaixo, os nós estão se comunicando.

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": "0x5"
}
```
 OBS: O result deve ser exatamente como o hexadecial acima que é == 5. Pois a requisição feita é para o nó 1, que retorna quem está conectado a ele. Que são os outros 5 nós.


## Use o método eth_blockNumber para verificar se a rede está produzindo blocos (coloque o ip na requisição):

```
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' http://<IP>:8545
```

OBS: Se o número de blocos estiver aumentando a cada requisição feita, a rede está produzindo blocos.

EX:

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": "0x987"
}
```
próxima requisição:
```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": "0x9a2"
}
```

