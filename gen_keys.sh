
#ssh-keygen -t dsa -N "" -f id_dsa_1

mkdir -p keys
mkdir -p keys/logs
for (( c=1; c<=$@; c++ ))
do
   ssh-keygen -t dsa -N "" -f keys/key_$c
done
