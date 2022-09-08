#!/bin/bash
# Use my composer to build code if the base directory is empty
# Use the composer-drupal-optimizations to reduce memory use!
if [ ! -f /var/www/drupal/composer.json ]; then
  echo "Empty codebase, seting up latest stable Drupal code using composer."
  mkdir -p /var/www/tmp
  cd /var/www/tmp
  chown drupal .
  sudo -u drupal composer create-project drupal/recommended-project:${VSITE_DRUPAL_VER} . --no-interaction  --no-install
  sudo -u drupal composer require --no-update drush/drush zaporylie/composer-drupal-optimizations:^1.1 --dev
  sudo -u drupal composer config --no-plugins allow-plugins.zaporylie/composer-drupal-optimizations true
  sudo -u drupal composer update
  cd /var/www/
  chown drupal drupal 
  rsync -avz tmp/ drupal
  chmod g+w /var/www/drupal/web/sites/default/
  mkdir -p /var/www/drupal/config/sync
  chown www-data:www-data /var/www/drupal/config/sync
else
  echo "Detected existing Drupal codebase."
fi
if [[ ! -z "$VSITE_SSH_USER" ]]; then
  service ssh start
  useradd -u 2001 $VSITE_SSH_USER
  cp /home/${VSITE_SSH_USER}/.ssh/hosted_id_rsa.pub /home/${VSITE_SSH_USER}/.ssh/authorized_keys
  chown $VSITE_SSH_USER:$VSITE_SSH_USER /home/${VSITE_SSH_USER}/.ssh
  chown $VSITE_SSH_USER:$VSITE_SSH_USER /home/${VSITE_SSH_USER}/.ssh/authorized_keys
  echo "%${VSITE_SSH_USER}	ALL=(ALL) NOPASSWD:ALL" >  /etc/sudoers.d/${VSITE_SSH_USER}
  # and now a crazy thing so that this user gets the environment variables from the uid = 1
  xargs -0 bash -c 'printf "export %q\n" "$@"' -- < /proc/1/environ > /home/${VSITE_SSH_USER}/.profile
fi
