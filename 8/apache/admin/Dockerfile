# an extended version of the prosimulium webserver image for administration
ARG REPOSITORY_FROM=blackflysolutions/
FROM ${REPOSITORY_FROM}prosimulium:8-apache
# run apache as minimally as possible with a custom conf file
COPY admin.conf /etc/apache2/conf-available
RUN a2enconf admin
# add extra packages and scripts
RUN apt-get update \
  && apt-get install -y mariadb-client sudo vim git zip unzip netcat rsync ssh \
  && apt-get purge -y
# drush launcher: drush is/was installed by composer
RUN curl -L -o /usr/local/bin/drush https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar
RUN chmod ugo+x /usr/local/bin/drush
# wait-for-it script because I need a working sql container before installing
COPY wait-for-it.sh /usr/local/bin/wait-for-it.sh
# add composer, version 2 as of Apr 2021
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin
# add additional dependencies for installing civicrm with D8 + composer
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g bower
# create a user to own the drupal code and run the build process
# note that this user does not exist in the vhttp/run image!
RUN useradd -u 1978 -g www-data -ms /bin/bash drupal
RUN chown drupal:www-data /var/www/drupal
# copy all my scripts into /usr/local/bin
COPY *.sh /usr/local/bin/
RUN chmod ugo+x /usr/local/bin/*.sh 
RUN curl -LsS https://download.civicrm.org/cv/cv.phar -o /usr/local/bin/cv
RUN chmod ugo+x /usr/local/bin/cv 
# Run the same initialization script that vhttp does, and then the admin one.
# CMD apache2-foreground
CMD /usr/local/bin/initialize.sh && /usr/local/bin/admin.sh && apache2-foreground
