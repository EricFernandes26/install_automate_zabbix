# How to install freetds in Linux ubuntu?

## Install pre-requesite packages
sudo apt-get install unixodbc unixodbc-dev freetds-dev freetds-bin tdsodbc

Point odbcinst.ini to the driver in /etc/odbcinst.ini:

 ```bash
[FreeTDS]
Description = v0.91 with protocol v7.2
Driver = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so
 ```
 
Create your DSNs in /etc/odbc.ini:
```bash
[dbserverdsn]
Driver = FreeTDS
Server = dbserver.domain.com
Port = 1433
TDS_Version = 7.2

 ```
 
 and your DSNs in /etc/freetds.conf:
 ```bash
 [global]
    # TDS protocol version, use:
    # 7.3 for SQL Server 2008 or greater (tested through 2014)
    # 7.2 for SQL Server 2005
    # 7.1 for SQL Server 2000
    # 7.0 for SQL Server 7
    tds version = 7.2
    port = 1433

    # Whether to write a TDSDUMP file for diagnostic purposes
    # (setting this to /tmp is insecure on a multi-user system)
;   dump file = /tmp/freetds.log
;   debug flags = 0xffff

    # Command and connection timeouts
;   timeout = 10
;   connect timeout = 10
    
    # If you get out-of-memory errors, it may mean that your client
    # is trying to allocate a huge buffer for a TEXT field.  
    # Try setting 'text size' to a more reasonable limit 
    text size = 64512

# A typical Microsoft server
[dbserverdsn]
    host = dbserver.domain.com
    port = 1433
    tds version = 7.2
 ```


## Observações.

troque dbserver.domain.com pelo IPv4 privado do seu servidor.

troque[dbserverdsn] pelo nome IDENTICO ao seu banco de dados no seu servidor.

Apos ter feito isso teste a conexao usando o comando
 ```bash
 isql -v DSN_Name <usuario-do-banco> <senha-do-usuario>
 
 isql -v AdventureWorks2022 zbx password
  ```
