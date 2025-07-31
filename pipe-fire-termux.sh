#!/bin/bash

echo "==============================="
echo "🚀 Welcome to Pipe Firestarter"
echo "==============================="

# STEP 1: Clone and build pipe-cli
echo "[1/4] Cloning and installing pipe-cli..."
git clone https://github.com/PipeNetwork/pipe.git || { echo "❌ Failed to clone repo"; exit 1; }
cd pipe || { echo "❌ 'pipe' directory not found"; exit 1; }
cargo install --path . || { echo "❌ Failed to install pipe-cli"; exit 1; }
cd .. || exit

# STEP 2: Run 'pipe new-user' with username
echo "[2/4] Creating new Pipe user..."
read -p "👉 Enter a username for Pipe: " USERNAME
pipe new-user "$USERNAME" || { echo "❌ Failed to create user"; exit 1; }

# STEP 3: Generate dummy files
echo "[3/4] Creating dummy files..."
mkdir -p pipe-dummy
echo "This is a normal file." > pipe-dummy/myfile.pdf
echo "This is sensitive content." > pipe-dummy/sensitive.doc

# STEP 4: Test upload and download
echo "[4/4] Running upload and download commands..."

pipe upload-file pipe-dummy/myfile.pdf stored-name
pipe download-file stored-name downloaded.pdf

pipe upload-file pipe-dummy/sensitive.doc secure --encrypt
pipe download-file secure decrypted.doc --decrypt

echo ""
echo "✅ Done! follow @admirkhen for more"
