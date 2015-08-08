#!/bin/bash

cat << EOF > /tmp/inventory
test ansible_ssh_host=192.168.100.2
[$1]
test
EOF

echo -e "\e[92mTesting investory set up!"
echo -e "\e[92mTest with: \e[1mvagrant up \e[21mor \e[1mvagrant provision"
echo -e "\e[0m"
