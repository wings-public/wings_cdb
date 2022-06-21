# WiNGS_CDB

**Description**

This repository contains WiNGS central databse which refers to WiNGS_CDB. 

**Dependencies**
- [SQL Server Management Studio (SSMS)](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15)
- [SQL Server Data Tools (SSDT) for Visual Studio 2017](https://docs.microsoft.com/en-us/sql/ssdt/download-sql-server-data-tools-ssdt?view=sql-server-ver15)
- Visual Studio 2017

**Getting started**
- Install SQL Server 2019 Developer Edition
- Create required databses
  - run script 'WiNGS_Db'
  - run script 'WiNGS_data_Db'
  - run script 'WiNGS_BaseInfo_Db'
- Populate the databases with the necessary information 
  - run script 'script_populateTable' 
  - run script 'BaseInfo_DB'
- [Install SSIS in SQL server and create Integrated Service Catalog](https://www.mssqltips.com/sqlservertip/6635/install-ssis/)
- Deploy SSIS projects in SQL Server (all projects under SSIS folder)
- Create SQL Jobs in SQL Server Agent
  - run script 'WiNGS_Job' 

**Contacts**

Haleh.chizari@esat.kuleuven.be


