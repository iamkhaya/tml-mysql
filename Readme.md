# TML Mysql Instance

This is our Mysql Instance.

## Setting Up

### create persistant volume

## Usage

build docker image
```
export BRANCH=`git rev-parse --abbrev-ref HEAD`
export IMAGE_PATH="registry.digitalocean.com/tml-container-registry/tml-mysql:$BRANCH"
```

ht install tml-mysql charts/tml-mysql -f charts/tml-mysql/staging-values.yaml --namespace staging


helm delete tml-mysql

## Initializing the Database

```
k exec -it mysql-856d9dff7f-9jjt9 -- bash

mysql -v -u root -p password

use tml;
source schema/tml-api/ddl/create.sql;
source schema/tml-api/ddl/drop.sql
```

# install on
## Credential Management
current password is password TODO: https://thumela.atlassian.net/browse/TML-94

