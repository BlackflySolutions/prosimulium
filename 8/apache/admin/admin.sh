#!/bin/bash
# Use my composer to build code if the base directory is empty
# Use the composer-drupal-optimizations to reduce memory use!
if [ -z "$(ls -A /var/www/drupal)" ]; then
  echo "Empty codebase, seting up latest stable Drupal code using composer."
  cd /var/www/drupal
  chown drupal .
  sudo -u drupal composer create-project drupal/recommended-project . --no-interaction  --no-install
  sudo -u drupal composer require --no-update drush/drush zaporylie/composer-drupal-optimizations:^1.1 --dev
  sudo -u drupal composer install
  mkdir -p /var/www/drupal/config/sync
  chown www-data:www-data /var/www/drupal/config/sync
else
  echo "Detected existing Drupal codebase."
fi
