#!/data/data/com.termux/files/usr/bin/bash

echo "████████████████████████████████████████████████████████████████"
echo "██              SAINT KHEN PoP TERMUX INSTALLER               ██"
echo "████████████████████████████████████████████████████████████████"
sleep 1

# Prompt for user input
read -p "Enter PoP Name (e.g. khen1): " POP_NAME
read -p "Enter Location (e.g. nigeria): " POP_LOCATION
read -p "Enter Invite Code: " INVITE_CODE

# Update and install dependencies
pkg update -y && pkg upgrade -y
pkg install -y wget proot tar tmux

# Create working dir
mkdir -p /data/data/com.termux/files/usr/opt/popcache
cd /data/data/com.termux/files/usr/opt/popcache || exit 1

# Download ARM64 binary
wget -O pop-arm64.tar.gz https://download.pipe.network/static/pop-v0.3.0-linux-arm64.tar.gz

# Extract binary
tar -xzf pop-arm64.tar.gz
chmod +x ./pop

# Generate config
cat > config.json <<EOF
{
  "name": "$POP_NAME",
  "location": "$POP_LOCATION",
  "invite_code": "$INVITE_CODE",
  "memory_cache_mb": 2048,
  "disk_cache_gb": 50,
  "port_http": 8080,
  "port_https": 8443
}
EOF

# Start PoP node in tmux session
tmux new-session -d -s popnode './pop --config config.json'

echo "✅ PoP node launched in background tmux session: popnode"
echo "To attach: tmux attach-session -t popnode"
echo "To detach: press Ctrl+B then D"
echo "To monitor: curl -k https://localhost:8443/health | jq"
