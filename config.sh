apt install curl socat -y
curl https://get.acme.sh | sh

read -p "Enter Domain: " domain
read -p "Enter Email [Empty for default]: " email
email=${email:-amirhosseinfr79@gmail.com}
echo Email: $email
echo Domain: $domain

~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
~/.acme.sh/acme.sh --register-account -m $email
~/.acme.sh/acme.sh --issue -d $domain --standalone
~/.acme.sh/acme.sh --installcert -d $domain --key-file /root/private.key --fullchain-file /root/cert.crt
echo Setting BBR...
wget -N --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && bash bbr.sh
