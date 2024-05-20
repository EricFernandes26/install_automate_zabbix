#!/bin/bash

# Instalar o repositório Zabbix
wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu22.04_all.deb
dpkg -i zabbix-release_6.4-1+ubuntu22.04_all.deb
apt update

# Instalar o servidor Zabbix, frontend, agente e MySQL
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent mysql-server -y

# Criar banco de dados inicial
mysql -uroot << EOF
create database zabbix character set utf8mb4 collate utf8mb4_bin;
create user zabbix@localhost identified by 'zabbix';
grant all privileges on zabbix.* to zabbix@localhost;
set global log_bin_trust_function_creators = 1;
EOF

# Importar schema e dados iniciais
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix

# Desativar a opção log_bin_trust_function_creators
mysql -uroot << EOF
set global log_bin_trust_function_creators = 0;
EOF

# Editar o arquivo my.cnf e adicionar a configuração de fuso horário
echo -e "[mysqld]\ndefault-time-zone = \"-03:00\"" | tee -a /etc/mysql/my.cnf

# Reiniciar o serviço MySQL
sudo service mysql restart

# Configurar senha do banco de dados para o servidor Zabbix
sed -i 's/# DBPassword=/DBPassword=zabbix/' /etc/zabbix/zabbix_server.conf

# Reiniciar serviços e habilitá-los para inicialização no boot
systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2

echo "Instalação do servidor Zabbix concluída!"
