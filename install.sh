#!/bin/bash

install() {
    sudo easy_install pip
    sudo pip install ansible
}

printf "\e[92mChecking if Ansible is installed and the last version...\n"

if [[ -e /usr/bin/ansible ]] || [[ -e /usr/local/bin/ansible ]]; then
  ANSIBLE_VER=$(ansible --version)

  if ! [[ "$ANSIBLE_VER" =~ "1.9.3" ]]; then
     install
  fi
else
  install
fi

printf "\e[92mInstalling roles...\n"
printf "\e[0m\n"
ansible-galaxy install --force -p playbook/galaxy-roles -r requirements.txt
