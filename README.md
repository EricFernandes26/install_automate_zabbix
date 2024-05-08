# Install_automate_zabbix

Este repositório contém um script shell para automatizar a instalação de um servidor Zabbix e suas dependências em um ambiente Ubuntu 22.04.

## Descrição

O script segue os passos de instalação descritos na documentação oficial do Zabbix para a versão 6.4 no Ubuntu 22.04. Ele automatiza desde a instalação do repositório Zabbix até a configuração do servidor, frontend, agente e MySQL, seguindo as melhores práticas recomendadas.

## Como usar

1. Clone este repositório em sua máquina local:

   ```bash
   git clone https://github.com/EricFernandes26/install_automate_zabbix.git

2. Navegue até o diretório do repositório:

   ```bash
   cd install_automate_zabbix
   
3. Dê permissão de execução ao arquivo shell script:

   ```bash
   chmod +x install_zabbix.sh

4. Execute o script:
   ```bash
   ./install_zabbix.sh
Certifique-se de que o script está sendo executado com permissões de superusuário ou usando o comando sudo se necessário.

## Informações adicionais.

Versão do Zabbix: 6.4.

Sistema operacional suportado: Ubuntu 22.04.

Componentes instalados: servidor, frontend, agente.

Banco de dados: MySQL.

Servidor web: Apache.

## Observações.
O script só vai exigir que você pressione a tecla Enter algumas vezes e, em seguida, insira a senha do usuário do banco de dados, que no caso é 'zabbix'.

Para mais informações sobre a instalação do Zabbix, consulte o site oficial do Zabbix.


![image](https://github.com/EricFernandes26/install_automate_zabbix/assets/83287307/a7352da3-a74b-45f6-935f-64422dbfe6dd)
