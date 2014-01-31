define(
	'Benchmarks/physics/initBox2d',
	[
		'Benchmarks/physics/createBox2dContext'
	],
	function(
		createBox2dContext
	) {

		return function( spell ) {
			spell.box2dContext         = createBox2dContext()
			spell.box2dWorlds          = {}
		}
	}
)
