FROM hyperledger/besu:25.2.1

RUN apt-get update && apt-get install -y bash coreutils \
    && apt-get install -y curl

WORKDIR /app


COPY qbftConfig.json ./qbftConfig.json

# Copia os scripts start-node
COPY start-node*.sh /app/

# Define permissões exec
RUN for script in /app/start-node*.sh; do \
    chmod +x "$script"; \
done





COPY setup.sh /app/setup.sh
#baixa os pacotes necessarios / copia as chaves e o arquivo genesis para os nos especificos / apaga o networkfiles
RUN chmod +x /app/setup.sh && /app/setup.sh

RUN apt-get update && apt-get install -y jq

ENTRYPOINT ["besu"]
