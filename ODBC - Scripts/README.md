# Script de Instalação de ODBC para Bancos de Dados

---

## Objetivo

Este script foi criado para automatizar a instalação de drivers ODBC (Open Database Connectivity) para diferentes motores de banco de dados em sistemas Ubuntu/Debian. O ODBC é uma API padrão da indústria que permite que aplicativos se conectem a qualquer fonte de dados ODBC, como bancos de dados SQL.

---

## Funcionalidades

O script oferece as seguintes funcionalidades:

1. **Instalação do unixODBC:**
   - O unixODBC é uma implementação de código aberto da API ODBC para sistemas baseados em Unix. Esta função instala o unixODBC e seus pacotes de desenvolvimento necessários.

2. **Instalação do ODBC para MySQL/MariaDB:**
   - Este comando instala o driver ODBC para MySQL ou MariaDB, permitindo que aplicativos se conectem a esses bancos de dados por meio da API ODBC.

3. **Instalação do ODBC para PostgreSQL:**
   - Esta função instala o driver ODBC para PostgreSQL, permitindo a conexão de aplicativos a bancos de dados PostgreSQL usando a API ODBC.

4. **Instalação do ODBC para SQL Server:**
   - Esta função instala o driver ODBC para Microsoft SQL Server. No entanto, é necessário observar a verificação de compatibilidade do sistema operacional Ubuntu antes da instalação.

5. **Instalação do ODBC para Oracle:**
   - Esta função instala o driver ODBC para Oracle 21c, permitindo que aplicativos se conectem a esses bancos de dados por meio da API ODBC.

---

## Instruções de Uso

Para usar o script, siga estas etapas:

1. Execute o script com permissões de superusuário (sudo).
2. Escolha a opção correspondente ao banco de dados para o qual deseja instalar o driver ODBC.
3. Siga as instruções na tela para concluir a instalação.

---

## Configurações Adicionais

Para o driver ODBC do MySQL/MariaDB, o script adiciona automaticamente as seguintes configurações ao arquivo `/etc/odbcinst.ini`:
```[mysql]
Description=General ODBC for MySQL
Driver=/usr/lib/x86_64-linux-gnu/odbc/libmaodbc.so
Setup=/usr/lib/x86_64-linux-gnu/odbc/libmaodbc.so
FileUsage=1
```


Isso é útil para configurar corretamente o ODBC após a instalação.

---

## Nota

- Certifique-se de que o script seja executado em um ambiente Ubuntu/Debian compatível e que todas as dependências necessárias estejam presentes no sistema antes da execução.
- Recomenda-se revisar e modificar o script conforme necessário para atender aos requisitos específicos do ambiente e dos bancos de dados a serem conectados.

---

Este script simplifica o processo de instalação de drivers ODBC, permitindo uma configuração rápida e fácil para acesso a diferentes motores de banco de dados em sistemas Ubuntu/Debian.


