/**
 * @class Benchmarks.systems.bounceBalls
 * @singleton
 */

define(
	'Benchmarks/systems/bounceBalls',
	[
		'spell/math/random/XorShift32',
		'spell/functions'
	],
	function(
		XorShift32,
		
		_
	) {
		'use strict'
		
		var ballsAmount = 200
		
		
		/**
		 * Creates an instance of the system.
		 *
		 * @constructor
		 * @param {Object} [spell] The spell object.
		 */
		var bounceBalls = function( spell ) {
			var prng = new XorShift32( 12345 )	
			
			this.randomNumber = _.bind( prng.nextBetween, prng, 1, 5 )
		}
		
		bounceBalls.prototype = {
			/**
		 	 * Gets called when the system is created.
		 	 *
		 	 * @param {Object} [spell] The spell object.
			 */
			init: function( spell ) {
				var randomNumber   = this.randomNumber,
					entityManager  = spell.entityManager,
					physicsManager = spell.physicsManager

				for( var i = 0; i < ballsAmount; i++ ) {

					var id = entityManager.createEntity( { 
						entityTemplateId: 'Benchmarks.entities.Ball',
						 config: {
							"spell.component.2d.transform": {
								"translation": [ randomNumber(), randomNumber() ]
    				    	}   				    	
						}						
					})		
					
					physicsManager.setVelocity( id, [ randomNumber(), randomNumber() ] )
				}
			},
		
			/**
		 	 * Gets called when the system is destroyed.
		 	 *
		 	 * @param {Object} [spell] The spell object.
			 */
			destroy: function( spell ) {
				
			},
		
			/**
		 	 * Gets called when the system is activated.
		 	 *
		 	 * @param {Object} [spell] The spell object.
			 */
			activate: function( spell ) {

			},
		
			/**
		 	 * Gets called when the system is deactivated.
		 	 *
		 	 * @param {Object} [spell] The spell object.
			 */
			deactivate: function( spell ) {
				
			},
		
			/**
		 	 * Gets called to trigger the processing of game state.
		 	 *
			 * @param {Object} [spell] The spell object.
			 * @param {Object} [timeInMs] The current time in ms.
			 * @param {Object} [deltaTimeInMs] The elapsed time in ms.
			 */
			process: function( spell, timeInMs, deltaTimeInMs ) {
				var transforms = this.transformComponents,
					balls      = this.balls

			}
		}
		
		return bounceBalls
	}
)
