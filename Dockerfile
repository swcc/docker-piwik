FROM bradfeehan/php-nginx

# Install APT extra php5-fpm dependencies
RUN apt-get update
RUN apt-get install -o Dpkg::Options::="--force-confold" --force-yes -y php5-mysql

# Clean up when done
RUN apt-get clean && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /docker-build

# Add SSH keys for access
ADD ./docker.pub /tmp/
RUN mkdir -p ~/.ssh
RUN touch ~/.ssh/authorized_keys
RUN chmod 600 ~/.ssh/authorized_keys
RUN cat /tmp/docker.pub >> ~/.ssh/authorized_keys

# Use baseimage-docker's init process.
CMD /sbin/my_init
