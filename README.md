# OpenMpiCluster

This project helps setting up an OpenMpi cluster with as many nodes and user accounts specified. This project has ancible scripts that help in automation of the cluster building process. The project has been tested in ubuntu 14.04 and works flawless. This needs some more testing at this point of time. The instructions are crude and need to be polished so please bear with this. For assistance please email me. 

## Preparing the environment before starting the cluster building process

### Install ANSIBLE 
Install ansible in all the servers.

    $ sudo apt-get install software-properties-common

    $ sudo apt-add-repository ppa:ansible/ansible			

    $ sudo apt-get update

    $ sudo apt-get install ansible

### Install git

    $ sudo apt-get install git

### Generate a key pair for the main server or master server

    $ cd .ssh

    $ ssh-keygen -t dsa

Add the generated public key into authorized keys of all the servers in the cluster including the main node

### Creating ansible inventory file
Edit /etc/ansible/hosts (ansible inventory file) its always good to have a backup of hosts
We use local label for the main node and web label for rest of the servers.
The file should look something like this

    [web]
    hpc-test-2 ansible_ssh_host=10.242.148.231
    hpc-test ansible_ssh_host=10.242.148.230
    [local]
    hpc-main ansible_ssh_host=127.0.0.1

### Git clone OpenMpiCluster repo
    git clone https://github.com/mk01github/OpenMpiCluster.git

### To add more users edit the host_vars/hpc file 
This is a template file which we use to specify the names of users necessary. This file has some more parameters which are key in copying the key-pairs across the users in different serves. The hpc looks somthing like this.

    ---
    users:
       hpc_usr_1:
          password: $1$lZ6yqS5j$z9VaNiJ9UEBqxsPewMaoV/
          pubKey: "{{ lookup('file', '~/keys/key_1.pub') }}"
          privKeyPath: '/home/ubuntu/keys/key_1'
          pubKeyPath: '/home/ubuntu/keys/key_1.pub'

       hpc_usr_2:
          password: $1$lZ6yqS5j$z9VaNiJ9UEBqxsPewMaoV/
          pubKey: "{{ lookup('file', '~/keys/key_2.pub') }}"
          privKeyPath: '/home/ubuntu/keys/key_2'
          pubKeyPath: '/home/ubuntu/keys/key_2.pub'

        hpc_usr_3:
          password: $1$lZ6yqS5j$z9VaNiJ9UEBqxsPewMaoV/
          pubKey: "{{ lookup('file', '~/keys/key_3.pub') }}"
          privKeyPath: '/home/ubuntu/keys/key_3'
          pubKeyPath: '/home/ubuntu/keys/key_3.pub'

    mainPubKeyPath: "{{ lookup('file', '~/.ssh/id_dsa.pub') }}"

All the users and its parameters follow a pattern so just follow the pattern if new users are to be added.
for example if you want to add a new user named bla and we want this user account to use key-pair key-4, here is what you need to add.

       bla:
          password: $1$lZ6yqS5j$z9VaNiJ9UEBqxsPewMaoV/
          pubKey: "{{ lookup('file', '~/keys/key_4.pub') }}"
          privKeyPath: '/home/ubuntu/keys/key_4'
          pubKeyPath: '/home/ubuntu/keys/key_4.pub'

To change the password for the users hash of the desired passwerd is specified at password section ( see above)
We need to specify the hash of the password. Type in the following command to get the hash of the password.

    openssl passwd -1 "password"

The passwd command computes the hash of a password and -1 is to use the MD5 based BSD password algorithm 1.
## Cluster Building process 

### Run prep_vars ansible script
This script creates all the files necessary in host_vars folder. These files determine what user has to be created in a server. These can be manually added, but its recommended to use this script.

    ansible-playbook prep_vars.yml

### Build the cluster using create_mpi_cluster.xml
This script is the main script for building the cluster. It creates users in all the servers, copies key-pairs accross all users in all the serves, installs all the necessary projects, copies mpiHosts file accross all users in all servers and prepare the cluster.

    ansible-playbook create_mpi_cluster.xml

If this runs with no errors, the cluster should be ready.

Login into one of the  users using password or the private key from the keys folder in home directory of the system where you started the installation.

    su hcp-usr-1
Inside each usr home directory there is a mpi4pyexamples folder and a mpiHosts file. Now lets test our cluster.
test_all.py script in mpi4py examples folder gets the status of all the servers. here is how you run it

    mpirun -np 2 -machinefile mpiHosts python mpi4py_examples/test_all.py
    
### To copy the files across the cluster use copy_file.yml 

    ansible-playbook copy_file.yml

In this script the absolute path for source and destination should be specified
for example

    ---
     - hosts: all
        tasks:
        - name: Copy files across
          copy: src=/home/hpc_usr_1/copy_files.yml dest=/home/hpc_usr_1/


   
Wrote all the instructions in a hurry .. sorry if they are confusing.. send me an email if you need some assistance.. mkumar2301@gmail.com.. 


