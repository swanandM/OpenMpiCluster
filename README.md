# OpenMpiCluster

Before using the anscible scripts

### Install ANSIBLE

$ sudo apt-get install software-properties-common

$ sudo apt-add-repository ppa:ansible/ansible			

$ sudo apt-get update

$ sudo apt-get install ansible

### Install git

$ sudo apt-get install git

### Generate a key pair for the main server or master server

$ cd .ssh

$ ssh-keygen -t dsa

### Add the generated public key into authorized keys of all the servers in the cluster including the main node

### Edit /etc/ansible/hosts its always good to have a backup of hosts
We use local label for the main node and web label for rest of the servers.
The file should look something like this

    [web]

    hpc-test-2 ansible_ssh_host=10.242.148.231

    hpc-test ansible_ssh_host=10.242.148.230

    [local]

    hpc-main ansible_ssh_host=127.0.0.1
