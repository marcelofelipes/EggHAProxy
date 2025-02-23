# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: HAProxy
# Minimum Panel Version: 0.6.0
# ----------------------------------

# Usar a versão LTS do HAProxy baseada no Alpine
FROM haproxy:lts-alpine3.21

# Maintainer Information
MAINTAINER K

# Usar o usuário root temporariamente para criar o usuário container
USER root

# Criar o usuário e grupo para o container
RUN adduser --disabled-password --home /home/container --shell /bin/sh container

# Definir o diretório de trabalho
WORKDIR /home/container

# Copiar o script de entrada
COPY ./entrypoint.sh /entrypoint.sh

# Copiar a configuração do HAProxy para o diretório correto
COPY ./haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg

# Certifique-se de que o arquivo de configuração seja de propriedade do usuário container
RUN chown container:container /etc/haproxy/haproxy.cfg

# Voltar para o usuário 'container'
USER container

# Comando de inicialização
CMD ["/bin/sh", "/entrypoint.sh"]
