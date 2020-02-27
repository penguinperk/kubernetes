#!/bin/bash

# Join worker nodes to the Kubernetes cluster
echo "[TASK 1] Installing NFS Server (nfs-utils)"
yum install -q -y nfs-utils >/dev/null 2>&1

# Enable docker service
echo "[TASK 3] Enable and start docker service"
systemctl enable nfs-server >/dev/null 2>&1
systemctl start nfs-server

echo "[TASK 4] Creating Share"
mkdir -p /srv/nfs/kubedata
chmod -R 777 /srv/nfs/

echo "[TASK 4] Setup Export /srv/nfs/kubedata "
cat >>/etc/exports<<EOF
/srv/nfs/kubedata	*(rw,sync,no_subtree_check,insecure)
EOF

echo "[TASK 4] Exporting out /srv/nfs/kubedata "
exportfs -rav
exportfs -v


