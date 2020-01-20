#!/bin/bash
# Use my composer to update my drupal version
echo "Downloading CiviCRM Codebase using composer."
cd /var/www/drupal
# install civicrm code and do setup if not yet installed
if [ -d "/var/www/drupal/vendor/civicrm" ]; then
  echo "Detected existing CiviCRM codebase, aborted."
else
  sudo -u drupal composer require --no-update --dev roundearth/civicrm-composer-plugin
  sudo -u drupal composer require --no-update civicrm/civicrm-core:${VSITE_CIVICRM_VER}
  sudo -u drupal composer require --no-update civicrm/civicrm-drupal-8:${VSITE_CIVICRM_VER}
  sudo -u drupal composer update
  echo "CiviCRM codebase installed."
fi
