#!/bin/bash

# Atualiza os pacotes
sudo apt-get update -y

# Instala o MySQL
sudo apt-get install mysql-server -y

# Inicia o serviço MySQL
sudo systemctl start mysql

# Habilita o MySQL para iniciar no boot
sudo systemctl enable mysql

# Cria um banco de dados
DB_NAME="db_naregua"
DB_USER="admin-dba"
DB_PASS="SPTECHnaregua2024"

# Executa comandos SQL para criar o banco e o usuário
sudo mysql -e "CREATE DATABASE $DB_NAME;"
sudo mysql -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Executa um arquivo SQL
SQL_FILE="/scripts/criacao_db.sql"
sudo mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < "$SQL_FILE"

echo "Banco de dados $DB_NAME criado com sucesso e script SQL executado!"

