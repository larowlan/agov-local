# Default Drupal development site.

node default {

  # Basic includes.
  include drupal

  # Advanced includes.
  drupal::site { 'agov':
    mysql_host => '%',
  }

}

