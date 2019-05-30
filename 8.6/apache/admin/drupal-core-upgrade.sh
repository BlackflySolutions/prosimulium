#!/bin/bash
# Use my composer to update my drupal version
echo "Updating drupal"
cd /var/www/drupal
sudo -u drupal composer update drupal/core webflo/drupal-core-require-dev --with-dependencies
sudo -E -u www-data drush updatedb
sudo -E -u www-data drush cr
