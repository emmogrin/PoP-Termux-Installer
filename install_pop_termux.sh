#!/data/data/com.termux/files/usr/bin/bash

echo "████████████████████████████████████████████████████████████████"
echo "██        SAINT KHEN | PoP INSTALLER (TERMUX NATIVE)         ██"
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

# Install dependencies
pkg update -y && pkg upgrade -y
pkg install -y wget curl tmux jq tar

# Set working directory
mkdir -p $HOME/popcache && cd $HOME/popcache || exit 1

# Download and extract PoP binary
wget -O pop.tar.gz https://download.pipe.network/static/pop-v0.3.0-linux-arm64.tar.gz
tar -xzf pop.tar.gz
chmod +x ./pop

# Write config.json
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

# Launch node in tmux
tmux new-session -d -s popnode './pop --config config.json'

echo "✅ PoP node started in tmux session: popnode"
echo "To view logs: tmux attach-session -t popnode"
echo "To detach: press Ctrl+B then D"
echo "To check health:"
echo "curl -k https://localhost:8443/health | jq"
