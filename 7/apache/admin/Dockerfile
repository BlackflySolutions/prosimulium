# an extended version of the webserver image, adding extra packages and scripts
ARG REPOSITORY_FROM=blackflysolutions/
FROM ${REPOSITORY_FROM:-}prosimulium:7-apache
RUN apt-get update \
  && apt-get install -y mariadb-client sudo vim zip unzip netcat \
  && apt-get purge -y
COPY drush.phar /usr/local/bin/drush
COPY wait-for-it.sh /usr/local/bin/wait-for-it.sh
RUN useradd -u 1978 -g www-data -ms /bin/bash drupal
COPY default.settings.php settings.php /usr/local/src/
COPY admin.sh admindb.sh restoredb.sh setup.sh wait-for-it.sh backupdb.sh backupsite.sh /usr/local/bin/
RUN curl -LsS https://download.civicrm.org/cv/cv.phar -o /usr/local/bin/cv
RUN chmod ugo+x /usr/local/bin/drush && chmod ugo+x /usr/local/bin/cv && chmod ugo+x /usr/local/bin/*.sh 
COPY admin.conf /etc/apache2/conf-available
RUN a2enconf admin
RUN mkdir /var/www/.drush && chown www-data:www-data /var/www/.drush && sudo -E -u www-data drush -y @none dl --destination=/var/www/.drush registry_rebuild-7.x
# CMD["apache2-foreground"]
# Run the same initialization script that the web (drupal) does.
CMD /usr/local/bin/initialize.sh && apache2-foreground
