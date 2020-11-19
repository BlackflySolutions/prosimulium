#!/bin/bash
# Use my composer to build code if the base directory is empty
# Use the composer-drupal-optimizations to reduce memory use!
if [ -z "$(ls -A /var/www/drupal)" ]; then
  echo "Empty codebase, seting up latest stable Drupal code using composer."
  cd /var/www/drupal
  chown drupal .
  sudo -u drupal composer create-project drupal/recommended-project:${VSITE_DRUPAL_VER} . --no-interaction  --no-install
# will not be needed with composer 2 in the future:
  sudo -u drupal composer require --no-update drush/drush zaporylie/composer-drupal-optimizations:^1.1 --dev
  sudo -u drupal composer update
  chmod g+w web/sites/default/
  mkdir -p /var/www/drupal/config/sync
  chown www-data:www-data /var/www/drupal/config/sync
else
  echo "Detected existing Drupal codebase."
fi
