#!/bin/bash

# Atualizar pacotes e instalar dependências
echo "Atualizando pacotes e instalando dependências..."
apt-get update
apt-get install -y unixodbc unixodbc-dev curl alien wget

# Instalar ODBC para MySQL/MariaDB
echo "Instalando ODBC para MySQL/MariaDB..."
apt-get install -y odbc-mariadb
echo "[mysql]" | tee -a /etc/odbcinst.ini
echo "Description=General ODBC for MySQL" | tee -a /etc/odbcinst.ini
echo "Driver=/usr/lib/x86_64-linux-gnu/odbc/libmaodbc.so" | tee -a /etc/odbcinst.ini
echo "Setup=/usr/lib/x86_64-linux-gnu/odbc/libmaodbc.so" | tee -a /etc/odbcinst.ini
echo "FileUsage=1" | tee -a /etc/odbcinst.ini

# Instalar ODBC para PostgreSQL
echo "Instalando ODBC para PostgreSQL..."
apt-get install -y odbc-postgresql

# Instalar ODBC para SQL Server
echo "Instalando ODBC para SQL Server..."
curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | tee /etc/apt/sources.list.d/mssql-release.list
apt-get update
ACCEPT_EULA=Y apt-get install -y msodbcsql18
ACCEPT_EULA=Y apt-get install -y mssql-tools18
echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
source ~/.bashrc

# Instalar ODBC para Oracle
echo "Instalando ODBC para Oracle..."
wget https://download.oracle.com/otn_software/linux/instantclient/2114000/oracle-instantclient-basic-21.14.0.0.0-1.el8.x86_64.rpm
wget https://download.oracle.com/otn_software/linux/instantclient/2114000/oracle-instantclient-odbc-21.14.0.0.0-1.el8.x86_64.rpm
alien --to-deb oracle-instantclient-basic-21.14.0.0.0-1.el8.x86_64.rpm
alien --to-deb oracle-instantclient-odbc-21.14.0.0.0-1.el8.x86_64.rpm
dpkg -i oracle-instantclient-basic_21.14.0.0.0-2_amd64.deb
dpkg -i oracle-instantclient-odbc_21.14.0.0.0-2_amd64.deb

# Configurar tnsnames.ora
echo "Configurando tnsnames.ora..."
mkdir -p /usr/lib/oracle/21/client64/lib/network/admin/
cat <<EOF > /usr/lib/oracle/21/client64/lib/network/admin/tnsnames.ora
XE =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = <IP-SERVER-ORACLE>)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = XE)
    )
  )
EOF

# Atualizar ~/.bashrc
echo "Atualizando ~/.bashrc..."
echo "export LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
echo "export TNS_ADMIN=/usr/lib/oracle/21/client64/lib/network/admin/tnsnames.ora" >> ~/.bashrc
source ~/.bashrc

# Configurar odbcinst.ini para Oracle
echo "Configurando odbcinst.ini para Oracle..."
cat <<EOF >> /etc/odbcinst.ini

[OracleODBC]
Description     = Oracle ODBC driver for Oracle 21
Driver = /usr/lib/oracle/21/client64/lib/libsqora.so.21.1
FileUsage=1
Driver Logging=7
EOF

echo "Instalação e configuração dos drivers ODBC concluídas!"
