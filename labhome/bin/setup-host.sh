#!/bin/bash

cd ~/labhome/kube*
vagrant destroy -f

rm -rf ~/labhome
ln -s ~/docker-k8s-fund/labhome ~/labhome

# install minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo cp minikube /usr/local/bin/ && rm minikube

# install labctl tool
sudo ln -s ~/labhome/bin/labctl /usr/local/bin/labctl

# optional, but recommended
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE

# add Typora's repository
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt-get update

# install typora
sudo apt-get install typora

# install docker
sudo apt-get install docker.io docker-compose vim
sudo usermod -aG docker $USER

# install kubectl
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo touch /etc/apt/sources.list.d/kubernetes.list 
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# copy dot files
cp ~/labhome/bin/user-home/.bash_alias ~/
cp ~/labhome/bin/user-home/.bashrc ~/
cp ~/labhome/bin/user-home/.vimrc ~/

# Reboot after setup
sudo reboot
