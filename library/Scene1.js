define(
	'Scene1',
	[
		'spell/math/random/XorShift32',
		'spell/functions'	  
	],
	function(
		XorShift32,
	  _
	) {
		'use strict'
        var ballsAmount = 100


        /**
         * Creates an instance of the system.
         *
         * @constructor
         * @param {Object} [spell] The spell object.
         */
        var prng = new XorShift32( 12345 )

        var randomNumber = _.bind( prng.nextBetween, prng, -10, 10 )
        var randomNumberTranslation = _.bind( prng.nextBetween, prng, -5, 5 )

        return {
            init : function( spell, sceneConfig ) {

                var entityManager  = spell.entityManager,
					physicsManager = spell.physicsManager

                for( var i = 0; i < ballsAmount; i++ ) {

                    var id = entityManager.createEntity( {
                        entityTemplateId: 'Benchmarks.entities.Ball',
                        config: {
                            "spell.component.2d.transform": {
                                "translation": [ randomNumberTranslation(), randomNumberTranslation() ]
                            }
                        }
                    })

					physicsManager.setVelocity( id, [ randomNumber(), randomNumber() ] )
                }
            },
            destroy : function( spell, sceneConfig ) {}
		}
	}
)
