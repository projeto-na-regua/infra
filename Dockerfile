# Usar a imagem oficial do MySQL como base
FROM mysql:8.0

# Instalar sudo e outras dependências necessárias
USER root

RUN apt-get update && \
    apt-get install -y sudo apt-utils && \
    apt-get upgrade -y && \
    apt-get clean

# Definir variáveis de ambiente para o banco
ENV MYSQL_ROOT_PASSWORD=root \
    MYSQL_DATABASE=db_naregua \
    MYSQL_USER=admin-dba \
    MYSQL_PASSWORD=SPTECHnaregua2024 \
    DEBIAN_FRONTEND=noninteractive

# Copiar o arquivo SQL para o diretório de inicialização
COPY init.sql /docker-entrypoint-initdb.d/

# Expor a porta padrão do MySQL
EXPOSE 3306

# Usar o entrypoint padrão que mantém o MySQL rodando
CMD ["mysqld"]
