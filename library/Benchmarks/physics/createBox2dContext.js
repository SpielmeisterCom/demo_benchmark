define(
	'Benchmarks/physics/createBox2dContext',
	[
		'Benchmarks/physics/createBox2dWorld'
	],
	function(
		createBox2dWorld
	) {
		'use strict'


		return function() {
			return {
				createWorld : createBox2dWorld
			}
		}
	}
)
