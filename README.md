Pipe Network PoP Installer (Termux Edition)

By @admirkhen | Lightweight setup for running a PoP Cache Node on Android using Termux + proot-distro (Ubuntu)


---

Requirements

Android device

Termux app

proot-distro installed



---

Setup Guide (Termux)

1. Install Termux & setup Ubuntu
```bash
pkg update && pkg install proot-distro -y
proot-distro install ubuntu
proot-distro login ubuntu
```

---

2. Install PoP Node inside Ubuntu
```bash
apt update && apt install curl wget -y
curl -O https://raw.githubusercontent.com/emmogrin/PoP-Termux-Installer/main/install_pop_termux.sh
chmod +x install_pop_termux.sh
./install_pop_termux.sh
```
You'll be asked to enter details like:

PoP Name

Location

Invite Code

Email, Discord, Telegram

Solana Wallet Address




---

3. Watch Logs (auto on first run)

Logs will show automatically after setup finishes.

To check logs later (e.g. after reboot):

```bash
proot-distro login ubuntu
tail -f ~/popcache/pop.log
```

---

Auto-Restart on Reboot

Your node auto-starts each time you log into Ubuntu:
```bash
proot-distro login ubuntu
```
That’s it — the node runs silently in the background and logs everything to ~/popcache/pop.log.


---

Credits

Built with love❤❤️❤ by @admirkhen to make node farming easy for mobile users.

