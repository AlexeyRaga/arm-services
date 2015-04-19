#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

echo "Pulling new version of containers"
docker pull alexeyraga/arm-consul
docker pull alexeyraga/arm-registrator

echo "Installing services in ${DIR}"

sed -i 's|$BASE_DIR|'${DIR}'|g' ${DIR}/consul/consul.service
sed -i 's|$BASE_DIR|'${DIR}'|g' ${DIR}/registrator/registrator.service

systemctl enable systemd-networkd-wait-online.service
systemctl enable ${DIR}/consul/consul.service
systemctl enable ${DIR}/registrator/registrator.service

echo "Services enabled."
echo "To start manually run:"
echo systemctl start consul.service
echo systemctl start registrator.service