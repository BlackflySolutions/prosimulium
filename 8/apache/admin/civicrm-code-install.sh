#!/bin/bash
# Use my composer to update my drupal version
echo "Downloading CiviCRM Codebase using composer."
cd /var/www/drupal
# install civicrm code and do setup if not yet installed
if [ -d "/var/www/drupal/vendor/civicrm" ]; then
  echo "Detected existing CiviCRM codebase, aborted."
else
  sudo -u drupal composer require --no-update civicrm/civicrm-asset-plugin:'~1.0.0' pear/pear_exception:'1.0.1 as 1.0.0' --prefer-source
  sudo -u drupal composer require --no-update civicrm/civicrm-core:${VSITE_CIVICRM_VER}
  sudo -u drupal composer require --no-update civicrm/civicrm-packages:${VSITE_CIVICRM_VER}
  sudo -u drupal composer require --no-update civicrm/civicrm-drupal-8:${VSITE_CIVICRM_VER}
  sudo -u drupal composer update
  echo "CiviCRM codebase installed."
fi
