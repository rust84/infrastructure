#Fix for guest customization missing http_directory https://kb.vmware.com/s/article/2051469
ln -s /etc/dhcp /etc/dhcp3

# Set up sudo
echo 'ubuntu ALL=NOPASSWD:ALL' > /etc/sudoers.d/ubuntu

# Install ubuntu key
echo 'Install ubuntu SSH key'
mkdir -pm 700 /home/ubuntu/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIInP9GAskxelbmEOiLDiYfpDQcXUvvoQEjphI7JEhQ6J" > /home/ubuntu/.ssh/authorized_keys
chmod 0600 /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu:ubuntu /home/ubuntu/.ssh
