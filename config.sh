apt-get update -y && apt-get upgrade -y
apt install resolvconf
apt install curl socat -y
apt install curl -y

systemctl start resolvconf.service
systemctl enable resolvconf.service
# systemctl status resolvconf.service

read -p "Enter Domain: " domain
read -p "Enter Email [Empty for default]: " email
email=${email:-amirhosseinfr79@gmail.com}

echo Email: $email
echo Domain: $domain
read -p "Press enter to continue..."

echo Setting up DNS...
nano /etc/resolvconf/resolv.conf.d/head
systemctl restart resolvconf.service

echo Setting up Panel...
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
curl https://get.acme.sh | sh

echo Setting up SSL...
~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
~/.acme.sh/acme.sh --register-account -m $email
~/.acme.sh/acme.sh --issue -d $domain --standalone
~/.acme.sh/acme.sh --installcert -d $domain --key-file /root/private.key --fullchain-file /root/cert.crt
read -p "Press enter to continue..."
echo Setting BBR...
wget -N --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && bash bbr.sh
