#!/bin/bash

echo "Running node.sh"
#######################################################
################# Turn Off the Firewall ###############
#######################################################
echo "Turning off the Firewall..."
service firewalld stop
chkconfig firewalld off

#######################################################
############### Install H2O Driverless AI #############
#######################################################
echo "Installing H2O Driverless AI..."
cd /
curl -O https://s3.amazonaws.com/artifacts.h2o.ai/releases/ai/h2o/dai/rel-1.5.4-65/x86_64-centos7/dai-1.5.4-1.x86_64.rpm
rpm -i dai-1.5.4-1.x86_64.rpm

echo 0 > /proc/sys/vm/overcommit_memory
mkdir -p /opt/h2oai/dai/home/.driverlessai/
echo $key > /opt/h2oai/dai/home/.driverlessai/license.sig

#######################################################
################### GPU Configuration #################
#######################################################
nvidia-persistenced --user dai
nvidia-smi -pm 1

#######################################################
################ Start H2O Driverless AI ##############
#######################################################
sleep 1m
systemctl start dai
