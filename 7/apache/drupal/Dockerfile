# a modified version of the drupal container, specific to the prosimulium hosting architecture
FROM blackflysolutions/drupal:7-apache-civicrm-5
# RUN a2enmod rewrite
RUN a2enmod expires
RUN pecl install -o redis \
  && docker-php-ext-enable redis
