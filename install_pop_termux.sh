#!/bin/bash

echo "████████████████████████████████████████████████████████████████"
echo "██           SAINT KHEN | PoP UBUNTU INSTALLER (FULL)          ██"
echo "████████████████████████████████████████████████████████████████"
sleep 1

# Ask user for setup info
read -p "Enter PoP Name (e.g. khen1): " POP_NAME
read -p "Enter Location (e.g. nigeria): " POP_LOCATION
read -p "Enter Invite Code: " INVITE_CODE
read -p "Enter Email: " EMAIL
read -p "Enter Discord Username (e.g. jijinwang): " DISCORD
read -p "Enter Telegram Username (with @): " TELEGRAM
read -p "Enter Solana Wallet Address (for rewards): " SOLANA_PUBKEY

# Update & install dependencies
apt update -y && apt upgrade -y
apt install -y wget tar jq nodejs npm

# Install pm2 globally
npm install -g pm2

# Create working directory
mkdir -p ~/popcache
cd ~/popcache || exit 1

# Download and extract PoP binary (Linux x64)
wget -O pop.tar.gz https://download.pipe.network/static/pop-v0.3.0-linux-x64.tar.gz
tar -xzf pop.tar.gz
chmod +x ./pop

# Create full config.json
cat > config.json <<EOF
{
  "pop_name": "$POP_NAME",
  "pop_location": "$POP_LOCATION",
  "invite_code": "$INVITE_CODE",
  "server": {
    "host": "0.0.0.0",
    "port": 8443,
    "http_port": 8080,
    "workers": 20
  },
  "cache_config": {
    "memory_cache_size_mb": 2048,
    "disk_cache_path": "./cache",
    "disk_cache_size_gb": 50,
    "default_ttl_seconds": 86400,
    "respect_origin_headers": true,
    "max_cacheable_size_mb": 1024
  },
  "api_endpoints": {
    "base_url": "https://dataplane.pipenetwork.com"
  },
  "identity_config": {
    "node_name": "pipenode",
    "name": "$POP_NAME",
    "email": "$EMAIL",
    "website": "",
    "discord": "$DISCORD",
    "telegram": "$TELEGRAM",
    "solana_pubkey": "$SOLANA_PUBKEY"
  }
}
EOF

# Start PoP node using pm2
pm2 start ./pop --name popnode -- --config config.json

# Save pm2 process list and enable startup on reboot
pm2 save
pm2 startup systemd -u $(whoami) --hp $(eval echo ~$USER)

echo "✅ PoP node started with pm2 as 'popnode'"
echo "Use 'pm2 logs popnode' to view logs"
echo "Use 'pm2 stop popnode' to stop the node"
echo "To check health (replace localhost with your IP if remote):"
echo "curl -k https://localhost:8443/health | jq"#!/bin/bash

echo "████████████████████████████████████████████████████████████████"
echo "██           SAINT KHEN | PoP UBUNTU INSTALLER (FULL)          ██"
echo "████████████████████████████████████████████████████████████████"
sleep 1

# Ask user for setup info
read -p "Enter PoP Name (e.g. khen1): " POP_NAME
read -p "Enter Location (e.g. nigeria): " POP_LOCATION
read -p "Enter Invite Code: " INVITE_CODE
read -p "Enter Email: " EMAIL
read -p "Enter Discord Username (e.g. jijinwang): " DISCORD
read -p "Enter Telegram Username (with @): " TELEGRAM
read -p "Enter Solana Wallet Address (for rewards): " SOLANA_PUBKEY

# Update & install dependencies
apt update -y && apt upgrade -y
apt install -y wget tar jq nodejs npm

# Install pm2 globally
npm install -g pm2

# Create working directory
mkdir -p ~/popcache
cd ~/popcache || exit 1

# Download and extract PoP binary (Linux x64)
wget -O pop.tar.gz https://download.pipe.network/static/pop-v0.3.0-linux-x64.tar.gz
tar -xzf pop.tar.gz
chmod +x ./pop

# Create full config.json
cat > config.json <<EOF
{
  "pop_name": "$POP_NAME",
  "pop_location": "$POP_LOCATION",
  "invite_code": "$INVITE_CODE",
  "server": {
    "host": "0.0.0.0",
    "port": 8443,
    "http_port": 8080,
    "workers": 20
  },
  "cache_config": {
    "memory_cache_size_mb": 2048,
    "disk_cache_path": "./cache",
    "disk_cache_size_gb": 50,
    "default_ttl_seconds": 86400,
    "respect_origin_headers": true,
    "max_cacheable_size_mb": 1024
  },
  "api_endpoints": {
    "base_url": "https://dataplane.pipenetwork.com"
  },
  "identity_config": {
    "node_name": "pipenode",
    "name": "$POP_NAME",
    "email": "$EMAIL",
    "website": "",
    "discord": "$DISCORD",
    "telegram": "$TELEGRAM",
    "solana_pubkey": "$SOLANA_PUBKEY"
  }
}
EOF

# Start PoP node using pm2
pm2 start ./pop --name popnode -- --config config.json

# Save pm2 process list and enable startup on reboot
pm2 save
pm2 startup systemd -u $(whoami) --hp $(eval echo ~$USER)

echo "✅ PoP node started with pm2 as 'popnode'"
echo "Use 'pm2 logs popnode' to view logs"
echo "Use 'pm2 stop popnode' to stop the node"
echo "To check health (replace localhost with your IP if remote):"
echo "curl -k https://localhost:8443/health | jq"
