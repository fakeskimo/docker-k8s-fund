
ln -s ~/docker-k8s-fund/labhome ~/labhome
sudo ln -s ~/labhome/bin/labctl /usr/local/bin/labctl


curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo cp minikube /usr/local/bin/ && rm minikube


# optional, but recommended
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE

# add Typora's repository
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt-get update

# install typora
sudo apt-get install typora

sudo apt-get install docker.io docker-compose vim 


echo 'eval "$(minikube completion bash)"' >> ~/.bashrc
echo 'eval "$(kubectl completion bash)"' >> ~/.bashrc

cp -r ~/labhome/bin/user-home/* ~/

