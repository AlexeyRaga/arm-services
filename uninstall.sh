#!/bin/bash

echo "Uninstalling services"

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

systemctl stop registrator
systemctl stop consul

systemctl disable registrator
systemctl disable consul

sed -i 's|'${DIR}'|$BASE_DIR|g' ${DIR}/consul/consul.service
sed -i 's|'${DIR}'|$BASE_DIR|g' ${DIR}/registrator/registrator.service