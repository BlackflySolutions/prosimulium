# an extended version of the drupal-civicrm container, specific to the prosimulium hosting architecture
ARG REPOSITORY_FROM=blackflysolutions/
FROM ${REPOSITORY_FROM}drupal:9-apache-civicrm-5
RUN a2enmod expires
RUN pecl install -o redis && docker-php-ext-enable redis
RUN pecl install -o apcu && docker-php-ext-enable apcu
# Add a way to send mail out, assume the host can do mail. 
# Use iproute2 to figure my ip route out to the host.
# Install openssh-client for outgoing https requests!
RUN apt-get update && apt-get install -y msmtp imagemagick openssh-client iproute2 git libtidy-dev && \
  pecl install -o imagick-3.4.3 && docker-php-ext-enable imagick && \
  apt-get clean && \
  echo 'sendmail_path = "/usr/bin/msmtp -C /etc/msmtprc -t"' > /usr/local/etc/php/conf.d/mail.ini
COPY msmtprc /etc/msmtprc
# add the exif and tidy extensions
RUN docker-php-ext-install exif tidy && docker-php-ext-enable tidy
# increase php timeout and other customizations
COPY vhttp.ini /usr/local/etc/php/conf.d/
COPY vhttp.conf /etc/apache2/conf-available/
RUN a2enconf vhttp
# initialize needs to run after the container has been created. 
COPY initialize.sh /usr/local/bin/initialize.sh
RUN chmod u+x /usr/local/bin/initialize.sh 
# CMD["apache2-foreground"]
CMD /usr/local/bin/initialize.sh && apache2-foreground
