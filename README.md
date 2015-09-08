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

### Edit /etc/ansible/hosts (ansible inventory file) its always good to have a backup of hosts
We use local label for the main node and web label for rest of the servers.
The file should look something like this

    [web]

    hpc-test-2 ansible_ssh_host=10.242.148.231

    hpc-test ansible_ssh_host=10.242.148.230

    [local]

    hpc-main ansible_ssh_host=127.0.0.1

### Git clone OpenMpiCluster repo
    git clone 

### Create the host_vars yml files for each server
Each server has to have its own file in host_vars with its ansible inventory name as title. 
These files are used to determine some essential parameters while building the cluster.
There are the files which are used to add users. Here is how they look like
    
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

    

    
    
    
    
    
   
