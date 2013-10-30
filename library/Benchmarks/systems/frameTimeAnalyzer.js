/**
 * @class Benchmarks.systems.frameTimeAnalyzer
 * @singleton
 */

define(
	'Benchmarks/systems/frameTimeAnalyzer',
	[
		'spell/shared/util/StopWatch'
	],
	function(
		StopWatch
	) {
		'use strict'
		
		
		
		/**
		 * Creates an instance of the system.
		 *
		 * @constructor
		 * @param {Object} [spell] The spell object.
		 */
		var frameTimeAnalyzer = function( spell ) {
			
		}
		
		frameTimeAnalyzer.prototype = {
			/**
		 	 * Gets called when the system is created.
		 	 *
		 	 * @param {Object} [spell] The spell object.
			 */
			init: function( spell ) {
				this.stopWatch = new StopWatch()
				this.stopWatch.start()
				this.sum      = 0
				this.numItems = 0
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
			    var frameTime     = this.frameTimeComponents,
			    	entityManager = spell.entityManager,
					elapsedTime   = this.stopWatch.stop(),
					sum           = this.sum
								
				this.stopWatch.start()

				if( sum >= 1000 ) {
					var average = sum / this.numItems
					
					entityManager.updateComponentAttribute( entityManager.getEntityIdsByName( 'fps' )[0], 'spell.component.2d.graphics.textAppearance', 'text',  this.numItems )
					
					for(var key in frameTime) { 
						entityManager.updateComponentAttribute( key, 'spell.component.2d.graphics.textAppearance', 'text', average | 0 )
					}
					
					this.sum = 0
					this.numItems = 0					
				} else {
					this.sum = sum + elapsedTime
					this.numItems++
				}
			}
		}
		
		return frameTimeAnalyzer
	}
)
