#!/bin/bash

# Atualizar pacotes e instalar alien
echo "Atualizando pacotes e instalando alien..."
sudo apt update
sudo apt install -y alien

# Baixar arquivos ODBC do ORACLE 21
echo "Baixando arquivos ODBC do ORACLE 21..."
wget https://download.oracle.com/otn_software/linux/instantclient/2114000/oracle-instantclient-basic-21.14.0.0.0-1.el8.x86_64.rpm
wget https://download.oracle.com/otn_software/linux/instantclient/2114000/oracle-instantclient-odbc-21.14.0.0.0-1.el8.x86_64.rpm

# Converter arquivos RPM para DEB usando alien
echo "Convertendo arquivos RPM para DEB..."
sudo alien --to-deb oracle-instantclient-basic-21.14.0.0.0-1.el8.x86_64.rpm
sudo alien --to-deb oracle-instantclient-odbc-21.14.0.0.0-1.el8.x86_64.rpm

# Instalar pacotes DEB convertidos
echo "Instalando pacotes DEB..."
sudo dpkg -i oracle-instantclient-basic_21.14.0.0.0-2_amd64.deb
sudo dpkg -i oracle-instantclient-odbc_21.14.0.0.0-2_amd64.deb

# Esperar um momento para garantir que a instalação esteja concluída
sleep 5

# Criar e configurar tnsnames.ora
echo "Configurando tnsnames.ora..."
sudo mkdir -p /usr/lib/oracle/21/client64/lib/network/admin/
sudo touch /usr/lib/oracle/21/client64/lib/network/admin/tnsnames.ora
sudo bash -c 'cat <<EOF > /usr/lib/oracle/21/client64/lib/network/admin/tnsnames.ora
XE =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = <IP-SERVER-ORACLE>)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = XE)
    )
  )
EOF'

# Atualizar ~/.bashrc
echo "Atualizando ~/.bashrc..."
echo "export LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
echo "export TNS_ADMIN=/usr/lib/oracle/21/client64/lib/network/admin/tnsnames.ora" >> ~/.bashrc
source ~/.bashrc

# Configurar odbcinst.ini
echo "Configurando odbcinst.ini..."
sudo bash -c 'cat <<EOF >> /etc/odbcinst.ini

[OracleODBC]
Description     = Oracle ODBC driver for Oracle 21
Driver = /usr/lib/oracle/21/client64/lib/libsqora.so.21.1
FileUsage=1
Driver Logging=7
EOF'

echo "Instalação e configuração concluídas!"
