login_ssh="docker"

service ssh start > /home/${login_ssh}/services.log
ushare -d -D >> /home/${login_ssh}/services.log
chmod -f 777 /home/${login_ssh}/services.log