#!/bin/bash

echo "████████████████████████████████████████████████████████████████"
echo "██           SAINT KHEN | @admirkhen | follow for more  ❣️👾❣️     ██"
echo "████████████████████████████████████████████████████████████████"
sleep 1

# Ask user for setup info
read -p "Enter PoP Name (e.g. khen1): " POP_NAME
read -p "Enter Location (e.g. japan): " POP_LOCATION
read -p "Enter Invite Code: " INVITE_CODE
read -p "Enter Email: " EMAIL
read -p "Enter Discord Username (e.g. jijinwang): " DISCORD
read -p "Enter Telegram Username (with @): " TELEGRAM
read -p "Enter Solana Wallet Address (for rewards): " SOLANA_PUBKEY

# Create working directory
mkdir -p ~/popcache
cd ~/popcache || exit 1

# Download and extract PoP binary
wget -O pop-arm64.tar.gz https://download.pipe.network/static/pop-v0.3.0-linux-arm64.tar.gz
tar -xzf pop-arm64.tar.gz
chmod +x ./pop

# Create full config.json
cat > config.json <<EOF
{
  "pop_name": "$POP_NAME",
  "pop_location": "$POP_LOCATION",
  "invite_code": "$INVITE_CODE",
  "server": {
    "host": "0.0.0.0",
    "port": 443,
    "http_port": 80,
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

# Start PoP Node in background & log output
echo "Starting PoP Node..."
nohup ./pop --config config.json > ~/popcache/pop.log 2>&1 &

sleep 2
echo "✅ PoP Node started in background."
echo "📄 Showing live logs now (press Ctrl+C to stop viewing logs)..."
sleep 2
tail -f ~/popcache/pop.log
