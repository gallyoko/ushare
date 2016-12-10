login_ssh=docker

mkdir -p /home/apps/ushare
chmod -Rf 777 /home/apps/ushare
chown -R ${login_ssh}:${login_ssh} /home/apps/ushare