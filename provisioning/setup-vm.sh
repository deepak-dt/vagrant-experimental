#!/usr/bin/env bash
set -xe

# git clone https://github.com/deepak-dt/vagrant-openstack-helm-contrail -b osh-contrail-ocata
# git config --global user.email "deepak.dt@gmail.com"; git config --global user.name "Deepak Tiwari"

proxy_url=""

export http_proxy=${proxy_url}
export HTTP_PROXY=${proxy_url}
export https_proxy=${proxy_url}
export HTTPS_PROXY=${proxy_url}

export HOST_IP=9.9.9.6
export HOST_IP2=18.9.9.6
export username=ubuntu
export CURR_WORK="/opt"
export DNS_NAMESERVERS_WITHIN_PROXY="155.179.59.249,155.179.58.11,192.168.1.1"
export no_proxy=127.0.0.1,$HOST_IP,$HOST_IP2

if [ ! -z $http_proxy ]
then
# Proxy related settings - apt-get
cat << EOF | sudo tee -a /etc/apt/apt.conf
Acquire::http::Proxy "$http_proxy";
Acquire::https::Proxy "$https_proxy";
EOF

cat << EOF | sudo tee -a /etc/environment
http_proxy="$http_proxy"
HTTP_PROXY="$http_proxy"
https_proxy="$https_proxy"
HTTPS_PROXY="$https_proxy"
no_proxy="$no_proxy"
NO_PROXY="$no_proxy"
EOF
fi

git config --global user.email "deepak.dt@gmail.com"
git config --global user.name "Deepak Tiwari"
git config --global user.editor "vim"

sudo apt-get update -y
sudo apt-get install -y docker.io

if [ ! -z $http_proxy ]
then
# Proxy related settings -Docker
sudo mkdir -p /etc/systemd/system/docker.service.d

cat << EOF | sudo tee -a /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=$http_proxy"
Environment="HTTPS_PROXY=$https_proxy"
Environment="NO_PROXY=localhost,127.0.0.1,localaddress,.localdomain.com,docker-registry.somecorporation.com"
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker
fi

sudo docker login

cat << EOF | sudo tee -a /etc/hosts
${HOST_IP} $(hostname -s)
${HOST_IP2} $(hostname -s)
EOF

sudo -H chown -R ${username}:${username} $CURR_WORK/ 
mkdir -p ~/.ssh 
echo "$username ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$username

#################################
echo "-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEA3MHSuV4XuMMJZIEnT6y+tc2dVBVIZhh7IkuTFXrVPhhWvrzU
ShysRmx4UkW5OYnGHZVP+Bu2vWJsHKtUnt4dCLTlSIPAoli4F8IZJh/Wb1ow/eVn
hNpR//iwD/UMhWVL/NGoymq6Pk37wqiKqf9CX/P1vvFj9MldJsrcCMtVKRy+qGQ3
rCNefSyA5AlTcpkBu2vlIc5xgXUGllqZ5sGsHlz5xZ10HTHxhsEySZSikkmQnMh4
ZZEravyEUHaf0iXoAlEKqc5h9XVFyd4bpMbXPcSVsqi42VN8wS9F5JWODttEN2zd
VLt0CjIfmQwvcpxg5MtI8fcbj9ZimnHnMw4/1QIDAQABAoIBACJOuPn35oXfQbFt
5Pcb6JOGfeHYYOUE/vXoetZGvaclzy1bWT6fUCKtrtFSZqPLho+IaeIsJG0wQ479
DWyXJjn5KvznBOP2F74ReykSn5e0k5KRuVHLQB0gv/Pq6GQ+xt1mk+3JQmJ2ah7p
ZItg0SbqWhGvoBIlzSU/N4ziVLzLoe1Ee1tGDoRwuQLFHyLvxg7oDBpMhqWysMtf
AriRweXXwZgkNotqDHP+NwryH1KipkTanXyaoxcat90eIfF0VdSqm1rkcfpcXnNR
WN80eeLl1KgEapNvQ1yFiV3hvFI+CqQLu7uLadaOe4QmwOYDeYraWMxhY2TQ1a91
8vwAVq0CgYEA73DwFNxWbOXUrG0u9Lj47P7c0HNVqLwBWWpUo2OrUmMyUfumR9RG
AzQzuZ+heb9NXyyBK+cMQaLVy0SaMtlxM8OoDtDtRIcVE9hHfmnEEr7+zA/Rkubg
8ppKKvg4N8yIhtdic0l0StfMMWEvuAcY3RdPS1IJEklx6xyoTLA6DLcCgYEA7AYa
drfv4vmqSVrS+5Doq8fkY4V1+HJfR5MhyPpdsnFNtTA+o8LJTFn5zWPRrELcmc/E
8KuolmPxXK3oD8gDKxuvsbyVFbg2s7LOYkzZEPi8GMPQ0w45w8q6OkgBFh13Vtjn
zxRsZsDUhdENYMEJ7EFo5Zo+n+3WCgvPOP0NY9MCgYA33MeGdmmLeouFtutvmQAq
esOVtnLTrRk7fT1F6Wj9DbuduPJwa6vx72np8r4/o0wv2jhAv+TyI0Vx6Q14s5Zf
l1RMMJ5KkKFwQdNcQNzH6tuTTFV+ynLM5wZKxCKJkiSAIRwM/aQuGe6/zobNjopU
eq27SuZm58+2JLd3PN4uPQKBgCKnCr+fZdL3QO8gLJXOwrpl0Lxj3dwqPp7tlSpC
x/ro87XEbY3xjUhudWSYYTJfZrAWdx22tjvOVKN8zPN0NDLiD7uSqnjT4QQlHnQE
QGJjgopIRaKXFhgO7aSc6bvre5f+pJocr4WujgVPmh04elJ7kAEV0lf8vU4gSb5e
ONcNAoGAJix/1eiOjBrfS4xfZnoXuWtQVOcrw2p5aH/KKfIw+c+sD72mdxrjmmj0
ETM7YSkCaIlze5Vak3ygiHmsWW6DGnEgVvvsVGeOuYqP7k6GKrB+r0W3FUeCcKzL
GRvZKpTZERkPyT/x1AtWDVJOG8sPHj7Shhe/3u7uqIej9q++tiM=
-----END RSA PRIVATE KEY-----" > ~/.ssh/osh-contrail-key-pair-ubuntu.pem

echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcwdK5Xhe4wwlkgSdPrL61zZ1UFUhmGHsiS5MVetU+GFa+vNRKHKxGbHhSRbk5icYdlU/4G7a9Ymwcq1Se3h0ItOVIg8CiWLgXwhkmH9ZvWjD95WeE2lH/+LAP9QyFZUv80ajKaro+TfvCqIqp/0Jf8/W+8WP0yV0mytwIy1UpHL6oZDesI159LIDkCVNymQG7a+UhznGBdQaWWpnmwaweXPnFnXQdMfGGwTJJlKKSSZCcyHhlkStq/IRQdp/SJegCUQqpzmH1dUXJ3hukxtc9xJWyqLjZU3zBL0XklY4O20Q3bN1Uu3QKMh+ZDC9ynGDky0jx9xuP1mKaceczDj/V Generated-by-Nova" >> ~/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcwdK5Xhe4wwlkgSdPrL61zZ1UFUhmGHsiS5MVetU+GFa+vNRKHKxGbHhSRbk5icYdlU/4G7a9Ymwcq1Se3h0ItOVIg8CiWLgXwhkmH9ZvWjD95WeE2lH/+LAP9QyFZUv80ajKaro+TfvCqIqp/0Jf8/W+8WP0yV0mytwIy1UpHL6oZDesI159LIDkCVNymQG7a+UhznGBdQaWWpnmwaweXPnFnXQdMfGGwTJJlKKSSZCcyHhlkStq/IRQdp/SJegCUQqpzmH1dUXJ3hukxtc9xJWyqLjZU3zBL0XklY4O20Q3bN1Uu3QKMh+ZDC9ynGDky0jx9xuP1mKaceczDj/V Generated-by-Nova" >> ~/dt967u_public_key.pub
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/osh-contrail-key-pair-ubuntu.pem
eval $(ssh-agent -s)
ssh-add ~/.ssh/osh-contrail-key-pair-ubuntu.pem

read -p "Proceed with setting up tempest? Press y to continue or n to abort [y/n] : " yn
case $yn in
    [Nn]* ) echo "Aborting...."; exit;;
esac



