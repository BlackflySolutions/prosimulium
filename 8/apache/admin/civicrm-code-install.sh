#!/bin/bash
# Use my composer to update my drupal version
echo "Downloading CiviCRM Codebase using composer."
cd /var/www/drupal
# install civicrm code and do setup if not yet installed
if [ -d "/var/www/drupal/vendor/civicrm" ]; then
  echo "Detected existing CiviCRM codebase, aborted."
else
  sudo -u drupal composer require civicrm/civicrm-core:~5 civicrm/civicrm-drupal-8 roundearth/civicrm-composer-plugin
  echo "CiviCRM codebase installed."
fi
