#!/bin/bash

# Função para instalar o unixODBC
install_unixodbc() {
    echo "Instalando unixODBC..."
    sudo apt install unixodbc unixodbc-dev
}

# Função para instalar o ODBC do MySQL/MariaDB
install_mysql_odbc() {
    echo "Instalando ODBC para MySQL/MariaDB..."
    sudo apt update
    sudo apt install odbc-mariadb

    # Adicionando configurações ao arquivo odbcinst.ini
    echo "" | sudo tee -a /etc/odbcinst.ini
    echo "[mysql]" | sudo tee -a /etc/odbcinst.ini
    echo "Description=General ODBC for MySQL" | sudo tee -a /etc/odbcinst.ini
    echo "Driver=/usr/lib/x86_64-linux-gnu/odbc/libmaodbc.so" | sudo tee -a /etc/odbcinst.ini
    echo "Setup=/usr/lib/x86_64-linux-gnu/odbc/libmaodbc.so" | sudo tee -a /etc/odbcinst.ini
    echo "FileUsage=1" | sudo tee -a /etc/odbcinst.ini
}

# Função para instalar o ODBC do PostgreSQL
install_postgres_odbc() {
    echo "Instalando ODBC para PostgreSQL..."
    sudo apt update
    sudo apt install odbc-postgresql
}

# Função para instalar o ODBC do SQL Server
install_sqlserver_odbc() {
    if ! [[ "18.04 20.04 22.04 23.04" == *$(lsb_release -rs)* ]]; then
        echo "Ubuntu $(lsb_release -rs) não é suportado atualmente."
        exit 1
    fi

    echo "Instalando ODBC para SQL Server..."
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
    curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list
    sudo apt-get update
    sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18
    sudo ACCEPT_EULA=Y apt-get install -y mssql-tools18
    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
    source ~/.bashrc
    sudo apt-get install -y unixodbc-dev
}

# Menu principal
echo "Escolha a engine para baixar o ODBC:"
echo "1. MySQL/MariaDB"
echo "2. PostgreSQL"
echo "3. SQL Server"
echo "4. Sair"

read -p "Escolha uma opção: " option

case $option in
    1)
        install_mysql_odbc
        ;;
    2)
        install_postgres_odbc
        ;;
    3)
        install_sqlserver_odbc
        ;;
    4)
        echo "Saindo..."
        exit 0
        ;;
    *)
        echo "Opção inválida. Saindo..."
        exit 1
        ;;
esac
