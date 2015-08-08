#!/bin/bash

install_ubuntu() {
  sudo apt-get install software-properties-common
  sudo apt-add-repository ppa:ansible/ansible
  sudo apt-get update
  sudo apt-get install ansible
}

echo -e "\e[92mChecking if Ansible is installed and the last version..."

if [ -e /usr/bin/ansible ]; then
  ANSIBLE_VER=$(ansible --version)

  if ! [[ "$ANSIBLE_VER" =~ "1.9.2" ]]; then
     install_ubuntu
  fi
fi

echo -e "\e[92mInstalling roles..."
echo -e "\e[0m"
ansible-galaxy install --force -p playbook/galaxy-roles -r requirements.txt
