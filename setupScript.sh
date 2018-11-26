#!/bin/bash
#Ansible informations
read -p "enter vps ip
" vps_ip
read -p "enter ansible user name.
" ansible_user

ansible_yml_path="setup.yml"

#generate ssh key
read -p "generate a new ssh key?(only if no ssh key present):
[y/n]:
" rep
clear

#ssh key regen
if [ "$rep" = 'y' ]
then
    ssh-keygen -t rsa
fi
clear

#temp inventory
echo "[vps]" > temp_inv.inv
echo "$vps_ip ansible_ssh_user=root" >> temp_inv.inv

#Ansible actions 
read -p "push root key?
if not sshpass programis needed
(y/n)
" rep
if [ "$rep" = 'y' ]
then
	ssh-copy-id "root@$vps_ip"
        ansible-playbook -i temp_inv.inv  "$ansible_yml_path"
else
	ansible-playbook -i temp_inv.inv --become-method=su --become -K -k "$ansible_yml_path"
fi

#push ssh key
echo "push ssh key to server"
cat ansible_user/vars/main.yml | grep passwd
ssh-copy-id "$ansible_user"@"$vps_ip"
