<?php

/* ---------------------------------------------------------------------------------- */
/*  OpenCart Action (with support for the Override Engine)                            */
/*                                                                                    */
/*  Original file Copyright © 2012-2014 by Daniel Kerr (www.opencart.com)             */
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

final class Action {
	private $file;
	private $class;
	private $method;
	private $args = array();

	public function __construct($route_or_properties, $args = array()) {
		if (is_array($route_or_properties)) {
			$properties = $route_or_properties;
			$this->file = $properties['file'];
			$this->class = $properties['class'];
			$this->method = $properties['method'];
			$this->args = $properties['args'];
			return;
		}

		$route = $route_or_properties;
		$path = '';

		// Break apart the route
		$parts = explode('/', str_replace('../', '', (string)$route));

		foreach ($parts as $part) {
			$path .= $part;

			if (is_dir(DIR_APPLICATION . 'controller/' . $path)) {
				$path .= '/';

				array_shift($parts);

				continue;
			}

			$file = DIR_APPLICATION . 'controller/' . str_replace(array('../', '..\\', '..'), '', $path) . '.php';

			if (is_file($file)) {
				$this->file = $file;

				$this->class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $path);

				array_shift($parts);

				break;
			}
		}

		if ($args) {
			$this->args = $args;
		}

		$method = array_shift($parts);

		if ($method) {
			$this->method = $method;
		} else {
			$this->method = 'index';
		}
	}

	public function execute($registry) {
		// Stop any magical methods being called
		if (substr($this->method, 0, 2) == '__') {
			return false;
		}

		if (is_file($this->file)) {
			$factory = $registry->get('factory');
			if ($factory) {
				$controller = $factory->newController( $this->file, $this->class );
			} else {
				include_once($this->file);
				$class = $this->class;
				$controller = new $class($registry);
			}

			if (is_callable(array($controller, $this->method))) {
				return call_user_func(array($controller, $this->method), $this->args);
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
}