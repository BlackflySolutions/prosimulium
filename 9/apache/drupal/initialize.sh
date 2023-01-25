#!/bin/bash
# Set the mail, varnish and redis host domains to the docker host ip for this container network.
VHOST_DOCKER_IP=`/sbin/ip route | awk '/default/ { print $3 }'`
echo "$VHOST_DOCKER_IP mail varnish $VSITE_DOMAIN" >> /etc/hosts
# support for customizing your apache config, not recommended
if [ -f "/var/www/drupal/web/sites/default/conf/apache-custom.conf" ]; then
  cp /var/www/drupal/web/sites/default/conf/apache-custom.conf /etc/apache2/conf-available/vsite-custom.conf
  a2enconf vsite-custom
fi 
# support for a custom robots.txt
if [ -f "/var/www/drupal/web/sites/default/conf/robots.txt" ]; then
  cp /var/www/drupal/web/sites/default/conf/robots.txt /var/www/drupal/web/
fi 
