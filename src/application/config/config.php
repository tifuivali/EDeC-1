<?php

error_reporting(E_ALL);
ini_set("display_errors", 1);

/**
 * Configuration for: Base URL
 */
define('URL', 'http://localhost/EDeC/');
define('ADMIN_URL', 'http://localhost/EDeC/admin/');

define('APPLICATION_PATH', 'application/');
define('CONTROLLER_PATH', 'application/controllers/');
define('MODELS_PATH', 'application/models/');
define('VIEWS_PATH', 'application/views/');

define('DB_TYPE', 'oci');
define('DB_HOST', '');
define('DB_NAME', 'ORCL'); // Try ORCL if XE not working
define('DB_USER', 'SYSTEM'); // db username
define('DB_PASS', 'admin01'); // db pass