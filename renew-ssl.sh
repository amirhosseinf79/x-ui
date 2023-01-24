read -p "Enter Domain: " domain
read -p "Enter Email [Empty for default]: " email
email=${email:-amirhosseinfr79@gmail.com}

echo Email: $email
echo Domain: $domain
read -p "Press enter to continue..."

echo Setting up SSL...
~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
~/.acme.sh/acme.sh --register-account -m $email
~/.acme.sh/acme.sh --issue -d $domain --standalone
~/.acme.sh/acme.sh --installcert -d $domain --key-file /root/private.key --fullchain-file /root/cert.crt
