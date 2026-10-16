#!/bin/sh
# Adds the https://apt.kmckim.com apt repository and installs the tims command.
#   curl -fsSL https://apt.kmckim.com/tims/install.sh | sudo sh
# Then: sudo tims init --domain <this server's DNS name> --email <you>
set -eu
[ "$(id -u)" = 0 ] || { echo "run as root: curl -fsSL https://apt.kmckim.com/tims/install.sh | sudo sh" >&2; exit 1; }
command -v apt-get >/dev/null || { echo "needs apt (Ubuntu or Debian)" >&2; exit 1; }
install -d -m 0755 /etc/apt/keyrings
curl -fsSL https://apt.kmckim.com/key.gpg -o /etc/apt/keyrings/kmckim-apt.gpg
chmod 0644 /etc/apt/keyrings/kmckim-apt.gpg
cat > /etc/apt/sources.list.d/kmckim-apt.sources <<SRC
Types: deb
URIs: https://apt.kmckim.com
Suites: stable
Components: main
Signed-By: /etc/apt/keyrings/kmckim-apt.gpg
SRC
apt-get update
apt-get install -y tims
echo
echo "Installed: $(tims version). Next: sudo tims init --domain <DNS name> --email <you>"
