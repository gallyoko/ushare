# Ushare dans un container
#
# VERSION               0.0.1
#

FROM     ubuntu:yakkety
MAINTAINER Fwedoz "fwedoz@gmail.com"

# Definition des constantes
ENV login_ssh="docker"
ENV password_ssh="docker"

# Mise a jour des depots
RUN (apt-get update && apt-get upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)

# Ajout des depots necessaires
RUN apt-get install -y -q wget nano zip openssh-server ushare

# Ajout utilisateur "${login_ssh}"
RUN adduser --quiet --disabled-password --shell /bin/bash --home /home/${login_ssh} --gecos "User" ${login_ssh}

# Modification du mot de passe pour "${login_ssh}"
RUN echo "${login_ssh}:${password_ssh}" | chpasswd

# Configuration des dossiers
COPY install_dir.sh /root/install_dir.sh
RUN chmod -f 755 /root/install_dir.sh
RUN sh /root/install_dir.sh

# Configuration de UShare
RUN rm -f /etc/ushare.conf
COPY ushare.conf /etc/ushare.conf
RUN chmod -f 644 /etc/ushare.conf

# Ajout du script services.sh au demarrage
COPY services.sh /root/services.sh
RUN chmod -f 755 /root/services.sh
RUN echo "sh /root/services.sh" >> /root/.bashrc

# Ports
EXPOSE 22 49200

# Point de montage
VOLUME ["/home"]