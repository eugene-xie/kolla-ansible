#!/bin/bash

set -ex

apt-get update  && apt-get install -y sudo apt-transport-https curl python-dev libffi-dev libssl-dev python-oslo.config

if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
        touch /etc/apt/sources.list.d/docker.list
fi
echo "deb https://download.docker.com/linux/debian stretch stable" \
  >/etc/apt/sources.list.d/docker.list

curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
apt-get update && apt-get install -y ansible/stretch-backports git virtualenv docker-ce ufw

git clone git://git.openstack.org/openstack/kolla-ansible

virtualenv venv-for-kolla
source venv-for-kolla/bin/activate
cd kolla-ansible
pip install -r requirements.txt
python setup.py install

set +ex
