<?php

/* ---------------------------------------------------------------------------------- */
/*  OpenCart admin/index.php (with modififications for the Override Engine)           */
/*                                                                                    */
/*  Original file Copyright © 2015 by Daniel Kerr (www.opencart.com)                  */
/*  Modifications Copyright © 2015 by J.Neuhoff (www.mhccorp.com)                     */
/*                                                                                    */
/*  This file is part of OpenCart.                                                    */
/*                                                                                    */
/*  OpenCart is free software: you can redistribute it and/or modify                  */
/*  it under the terms of the GNU General Public License as published by              */
/*  the Free Software Foundation, either version 3 of the License, or                 */
/*  (at your option) any later version.                                               */
/*                                                                                    */
/*  OpenCart is distributed in the hope that it will be useful,                       */
/*  but WITHOUT ANY WARRANTY; without even the implied warranty of                    */
/*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                     */
/*  GNU General Public License for more details.                                      */
/*                                                                                    */
/*  You should have received a copy of the GNU General Public License                 */
/*  along with OpenCart.  If not, see <http://www.gnu.org/licenses/>.                 */
/* ---------------------------------------------------------------------------------- */
// Version
define('VERSION', '2.0.3.1');

// Configuration
if (is_file('config.php')) {
	require_once('config.php');
}

// Install
if (!defined('DIR_APPLICATION')) {
	header('Location: ../install/index.php');
	exit;
}

// Startup
require_once(DIR_SYSTEM . 'startup.php');

// Registry
$registry = new Registry();

// Factory
$factory = new Factory($registry);
$registry->set( 'factory', $factory );

// Config
$config = $factory->newConfig();
$registry->set('config', $config);

// Database
$db = $factory->newDB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);

// Settings
$query = $db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '0'");

foreach ($query->rows as $setting) {
	if (!$setting['serialized']) {
		$config->set($setting['key'], $setting['value']);
	} else {
		$config->set($setting['key'], unserialize($setting['value']));
	}
}

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Url
$url = $factory->newUrl(HTTP_SERVER, $config->get('config_secure') ? HTTPS_SERVER : HTTP_SERVER);	
$registry->set('url', $url);

// Log 
$log = $factory->newLog($config->get('config_error_filename'));
$registry->set('log', $log);

function error_handler($errno, $errstr, $errfile, $errline) {
	global $log, $config;

	// error suppressed with @
	if (error_reporting() === 0) {
		return false;
	}

	switch ($errno) {
		case E_NOTICE:
		case E_USER_NOTICE:
			$error = 'Notice';
			break;
		case E_WARNING:
		case E_USER_WARNING:
			$error = 'Warning';
			break;
		case E_ERROR:
		case E_USER_ERROR:
			$error = 'Fatal Error';
			break;
		default:
			$error = 'Unknown';
			break;
	}

	if ($config->get('config_error_display')) {
		echo '<b>' . $error . '</b>: ' . $errstr . ' in <b>' . $errfile . '</b> on line <b>' . $errline . '</b>';
	}

	if ($config->get('config_error_log')) {
		$log->write('PHP ' . $error . ':  ' . $errstr . ' in ' . $errfile . ' on line ' . $errline);
	}

	return true;
}

// Error Handler
set_error_handler('error_handler');

// Request
$request = $factory->newRequest();
$registry->set('request', $request);

// Response
$response = $factory->newResponse();
$response->addHeader('Content-Type: text/html; charset=utf-8');
$registry->set('response', $response);

// Cache
$cache = $factory->newCache('file');
$registry->set('cache', $cache);

// Session
$session = $factory->newSession();
$registry->set('session', $session);

// Language
$languages = array();

$query = $db->query("SELECT * FROM `" . DB_PREFIX . "language`"); 

foreach ($query->rows as $result) {
	$languages[$result['code']] = $result;
}

$config->set('config_language_id', $languages[$config->get('config_admin_language')]['language_id']);

// Language	
$language = $factory->newLanguage($languages[$config->get('config_admin_language')]['directory']);
$language->load($languages[$config->get('config_admin_language')]['directory']);
$registry->set('language', $language);

// Document
$registry->set('document', $factory->newDocument());

// Currency
$registry->set('currency', $factory->newCurrency($registry));

// Weight
$registry->set('weight', $factory->newWeight($registry));

// Length
$registry->set('length', $factory->newLength($registry));

// User
$registry->set('user', $factory->newUser($registry));

//OpenBay Pro
$registry->set('openbay', $factory->newOpenbay($registry));

// Event
$event = $factory->newMediator($registry);
$registry->set('event', $event);

$query = $db->query("SELECT * FROM " . DB_PREFIX . "event");

foreach ($query->rows as $result) {
	$event->register($result['trigger'], $result['action']);
}

// Front Controller
$controller = new Front($registry);

// Login
$controller->addPreAction($factory->newAction('common/login/check'));

// Permission
$controller->addPreAction($factory->newAction('error/permission/check'));

// Router
if (isset($request->get['route'])) {
	$action = $factory->newAction($request->get['route']);
} else {
	$action = $factory->newAction('common/dashboard');
}

// Dispatch
$controller->dispatch($action, $factory->newAction('error/not_found'));

// Output
$response->output();