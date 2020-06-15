# TML Mysql Instance

This is our Mysql Instance.

## Setting Up

### create persistant volume

## Usage

helm delete tml-mysql --purge

## Initializing the Database

```
k exec -it mysql-856d9dff7f-9jjt9 bash

mysql -v -u root

use tml;
source schema/tml-api/ddl/create.sql;
source schema/tml-api/ddl/drop.sql
source schema/tml-api/ddl/schema.sql;
```

## Credential Management
current password is password TODO: https://thumela.atlassian.net/browse/TML-94

## Contribution
