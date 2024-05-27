#!/bin/bash

# Função para remover o unixODBC
remove_unixodbc() {
    echo "Removendo unixODBC..."
    sudo apt remove --purge unixodbc unixodbc-dev
}

# Função para remover o ODBC do MySQL/MariaDB
remove_mysql_odbc() {
    echo "Removendo ODBC para MySQL/MariaDB..."
    sudo apt remove --purge odbc-mariadb
}

# Função para remover o ODBC do PostgreSQL
remove_postgres_odbc() {
    echo "Removendo ODBC para PostgreSQL..."
    sudo apt remove --purge odbc-postgresql
}

# Função para remover o ODBC do SQL Server
remove_sqlserver_odbc() {
    echo "Removendo ODBC para SQL Server..."
    sudo apt remove --purge msodbcsql18 mssql-tools18 unixodbc-dev
    sudo rm /etc/apt/sources.list.d/mssql-release.list
    sudo rm /etc/apt/trusted.gpg.d/microsoft.asc
}

# Menu principal
echo "Escolha a engine para remover o ODBC:"
echo "1. MySQL/MariaDB"
echo "2. PostgreSQL"
echo "3. SQL Server"
echo "4. Remover tudo"
echo "5. Sair"

read -p "Escolha uma opção: " option

case $option in
    1)
        remove_mysql_odbc
        ;;
    2)
        remove_postgres_odbc
        ;;
    3)
        remove_sqlserver_odbc
        ;;
    4)
        remove_mysql_odbc
        remove_postgres_odbc
        remove_sqlserver_odbc
        remove_unixodbc
        ;;
    5)
        echo "Saindo..."
        exit 0
        ;;
    *)
        echo "Opção inválida. Saindo..."
        exit 1
        ;;
esac
                                         