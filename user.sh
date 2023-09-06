#!/bin/bash
USER=systemadmin
useradd $USER && mkdir /home/$USER/.ssh/ && touch /home/$USER/.ssh/authorized_keys && chown -R $USER:$USER /home/$USER/.ssh && chmod 600 /home/$USER/.ssh/authorized_keys
echo "$USER        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
su - $USER -c "echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAiOY7BGJzuEvXCjPBtCMGWkGqiAklPxoCRxXkb1Sk9yAdGPIQGEMSO00CoSeNYsTkqrADIkXBF4rOcppU5iYwVtPKuCWq3FBNaWHHYPshDTKq4fdF70e+TL18xrJkGTfBENAk/f6Rx5mwH3Hmd30PGvQK124Auqlt/79QyU8/BFwWSepkUMGKVHb/8hDmgvq7mwh1G0KjXKuUC/vHrUWR/7rC7Km4R3kAct0ePQeEuQ+WeTpCuc8P5iLpFw+iWzicZrlGiRpLlCmt4eYsaoIb5OTZA4eqLLOxrw5m9jZPAZ1p3Pe4Jk9S4AZttqs3xedIheUL4XWhQzUaptCvdIkz0Q== system-admin' > /home/$USER/.ssh/authorized_keys"
