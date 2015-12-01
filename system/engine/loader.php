<?php

/* ---------------------------------------------------------------------------------- */
/*  OpenCart Loader (with support for the Override Engine)                            */
/*                                                                                    */
/*  Original file Copyright © 2014 by Daniel Kerr (www.opencart.com)                  */
/*  Modifications Copyright © 2014 by J.Neuhoff (www.mhccorp.com)                     */
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

final class Loader {
	private $registry;

	public function __construct($registry) {
		$this->registry = $registry;
	}

	public function __get($key) {
		return $this->registry->get($key);
	}

	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}

	public function controller($route, $args = array()) {
		if ($this->factory) {
			$action = $this->factory->newAction($route, $args);
		} else {
			$action = new Action($route, $args);
		}

		return $action->execute($this->registry);
	}

	public function model($model) {
		if ($this->factory) {
			$instance = $this->factory->newModel($model);
			$this->registry->set('model_' . str_replace('/', '_', $model), $instance );
			return;
		}

		$file = DIR_APPLICATION . 'model/' . $model . '.php';
		$class = 'Model' . preg_replace('/[^a-zA-Z0-9]/', '', $model);

		if (file_exists($file)) {
			include_once($file);

			$this->registry->set('model_' . str_replace('/', '_', $model), new $class($this->registry));
		} else {
			trigger_error('Error: Could not load model ' . $file . '!');
			exit();
		}
	}

	public function view($template, $data = array()) {
		if ($this->factory) {
			return $this->factory->loadView( $template, $data );
		}

		$file = DIR_TEMPLATE . $template;

		if (file_exists($file)) {
			extract($data);

			ob_start();

			require($file);

			$output = ob_get_contents();

			ob_end_clean();

			return $output;
		} else {
			trigger_error('Error: Could not load template ' . $file . '!');
			exit();
		}
	}

	public function library($library) {
		$file = DIR_SYSTEM . 'library/' . $library . '.php';

		if (file_exists($file)) {
			include_once($file);
		} else {
			trigger_error('Error: Could not load library ' . $file . '!');
			exit();
		}
	}

	public function helper($helper) {
		$file = DIR_SYSTEM . 'helper/' . $helper . '.php';

		if (file_exists($file)) {
			include_once($file);
		} else {
			trigger_error('Error: Could not load helper ' . $file . '!');
			exit();
		}
	}

	public function config($config) {
		$this->config->load($config);
	}

	public function language($language) {
		if ($this->factory) {
			$this->factory->loadLanguage($language);
		}
		return $this->language->load($language);
	}
}