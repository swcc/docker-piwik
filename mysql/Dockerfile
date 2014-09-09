FROM swcc/docker-mysql

# Overwrite default setup.sh
ADD build/setup.sh  /etc/mysql/mysql_setup.sh
RUN chmod +x        /etc/mysql/mysql_setup.sh

# Add SSH keys for access
ADD ./docker.pub /tmp/
RUN mkdir -p ~/.ssh
RUN touch ~/.ssh/authorized_keys
RUN chmod 600 ~/.ssh/authorized_keys
RUN cat /tmp/docker.pub >> ~/.ssh/authorized_keys

# Use baseimage-docker's init process.
CMD /sbin/my_init
