# an extended version of the admin image, adding extra packages and scripts
ARG REPOSITORY_FROM=blackflysolutions/
FROM ${REPOSITORY_FROM:-}prosimulium:7-apache-admin
RUN apt-get update \
  && apt-get install -y sassc nodejs node-less \
  && sed -i 's/^/#/' /etc/apt/sources.list.d/buster.list \
  && apt-get install -y emacs-nox \
  && apt-get purge -y
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
# RUN npm install -g bower
# Run the same initialization script that vhttp does
CMD /usr/local/bin/initialize.sh && apache2-foreground

