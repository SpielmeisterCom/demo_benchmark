package Spielmeister {
	import flash.debugger.enterDebugger
	public class ScriptModules implements ModuleDefinition {
		public function ScriptModules() {}

		public function load( define : Function, require : Function ) : void {
			define(
				'spell/scene/default',
				[
					'spell/functions'
				],
				function(
					_
				) {
					'use strict'
			
			
					return {
						init : function( spell, sceneConfig ) {
							spell.entityManager.createEntities( sceneConfig.entities )
						},
						destroy : function( spell, sceneConfig ) {}
					}
				}
			)
			
			define(
				'spell/script/editor/cameraMover',
				[
					'spell/functions'
				],
				function(
					_
				) {
					'use strict'
			
			
					var MIN_SCALE = 0.01
			
					var getActiveCameraId = function( cameras ) {
						if( !cameras || _.size( cameras ) === 0 ) return
			
						// Gets the first active camera. More than one camera being active is an undefined state and the first found active is used.
						var activeCameraId = undefined
			
						_.any(
							cameras,
							function( camera, id ) {
								if( camera.active ) {
									activeCameraId = id
			
									return true
								}
			
								return false
							}
						)
			
						return activeCameraId
					}
			
					var cameraMover = function(spell, editorSystem) {
			
						/**
						 * Specifies whether we're in drag mode or not
						 * @type {Boolean}
						 */
						this.dragEnabled = false
						this.lastMousePosition = null
			
						this.lastActiveCameraId = null
			
						this.editorCameraEntityId = null
					}
			
					cameraMover.prototype = {
			
						init: function( spell, editorSystem ) {
			
						},
			
						activate: function( spell, editorSystem ) {
							var lastActiveCameraTransform,
								lastActiveCamera
			
							//find current active camera
							this.lastActiveCameraId = getActiveCameraId( editorSystem.cameras )
			
							if ( this.lastActiveCameraId ) {
								spell.entityManager.updateComponent(
									this.lastActiveCameraId,
									'spell.component.2d.graphics.camera', {
										'active': false
									})
			
			
								lastActiveCameraTransform = editorSystem.transforms[ this.lastActiveCameraId ]
								lastActiveCamera          = editorSystem.cameras[ this.lastActiveCameraId ]
			
							} else {
								//no active camera found, so initalize a new one
								lastActiveCamera = {
									'width':        768,
									'height':       1024
								}
			
								lastActiveCameraTransform = {
									'translation':  [ 0, 0 ],
									'scale':        [ 1, 1 ],
									'rotation':     0
								}
							}
			
							//create editor camera
							this.editorCameraEntityId = spell.entityManager.createEntity({
								templateId: 'spell.entity.2d.graphics.camera',
								config: {
									'spell.component.2d.transform': {
										'translation': [ lastActiveCameraTransform[ 'translation' ][0], lastActiveCameraTransform[ 'translation' ][1] ],
										'scale': [ lastActiveCameraTransform[ 'scale' ][0], lastActiveCameraTransform[ 'scale' ][1] ]
									},
									'spell.component.2d.graphics.camera': {
										'active': true,
										'clearUnsafeArea': false,
										'height': lastActiveCamera[ 'height' ],
										'width': lastActiveCamera[ 'width' ]
									}
								}
							})
						},
			
						deactivate: function( spell, editorSystem ) {
							//restore last active camera
							spell.entityManager.updateComponent( this.lastActiveCameraId, 'spell.component.2d.graphics.camera', {
								'active': true
							})
			
							spell.entityManager.removeEntity( this.editorCameraEntityId )
							this.editorCameraEntityId = undefined
						},
			
						process: function ( spell, editorSystem, timeInMs, deltaTimeInMs) {
			
						},
			
						pointerDown: function( spell, editorSystem, event ) {
							//clear last mouse position
							this.lastMousePosition  = null
			
							if ( event.button == 2 ) {
								this.dragEnabled = true
							}
						},
			
						pointerUp: function( spell, editorSystem, event ) {
							this.lastMousePosition  = null
			
							if ( event.button == 2 ) {
								this.dragEnabled = false
							}
						},
			
						mouseWheel: function( spell, editorSystem, event ) {
							//zoom camera in and out on mousewheel event
							var currentScale = editorSystem.transforms[ this.editorCameraEntityId ].scale
			
							currentScale[ 0 ] = Math.max( currentScale[ 0 ] + event.direction * -0.5, MIN_SCALE )
							currentScale[ 1 ] = Math.max( currentScale[ 1 ] + event.direction * -0.5, MIN_SCALE )
						},
			
						pointerMove: function( spell, editorSystem, event ) {
							if ( !this.dragEnabled ) {
								return
							}
			
							if ( this.lastMousePosition === null ) {
								//first sample of mouse movement, save it and wait for the next one
								//to find out the movement direction
								this.lastMousePosition = [ event.position[ 0 ], event.position[ 1 ] ]
								return
							}
			
							var currentTranslation = editorSystem.transforms[ this.editorCameraEntityId ].translation,
								currentScale = editorSystem.transforms[ this.editorCameraEntityId ].scale
			
							currentTranslation[ 0 ] -= ( event.position[ 0 ] - this.lastMousePosition[ 0 ] ) * currentScale[ 0 ] * 0.5
							currentTranslation[ 1 ] += ( event.position[ 1 ] - this.lastMousePosition[ 1 ] ) * currentScale[ 1 ] * 0.5
			
							this.lastMousePosition = [ event.position[ 0 ], event.position[ 1 ] ]
						}
					}
			
					return cameraMover
			
			})
			
			define(
				'spell/script/editor/entityMover',
				[
					'spell/math/vec2',
					'spell/math/mat3',
					'spell/math/util',
					'spell/functions'
				],
				function(
					vec2,
					mat3,
					mathUtil,
					_
				) {
					'use strict'
			
			
					var isPointWithinEntity = function( worldPosition, entityId ) {
						var editorConfigurations = this.editorConfigurations,
							editorConfiguration  = editorConfigurations[ entityId ]
			
						var isOverlayEntity = _.contains(
							_.values( this.overlayEntityMap ),
							entityId
						)
			
						if( editorConfiguration && editorConfiguration.isSelectable === false) {
							return false
						}
			
			
						if(isOverlayEntity) {
							//no further processing for overlay entites
							return false
						}
			
						var transform = this.transforms[ entityId ],
						    entityDimensions = this.spell.entityManager.getEntityDimensions( entityId )
			
						if( !entityDimensions ) return false
			
						return mathUtil.isPointInRect( worldPosition, transform.worldTranslation, entityDimensions[ 0 ], entityDimensions[ 1 ], 0 )
			
					}
			
					var syncOverlayEntitesWithMatchedEntites = function( overlayEntityMap, matchedEntites ) {
						var entityManager = this.spell.entityManager
			
						for( var i= 0,length=matchedEntites.length; i<length; i++) {
			
							var entityId            = matchedEntites[ i ],
								transform           = this.transforms[ entityId ],
								name                = this.metadata[ entityId ],
								entityDimensions    = entityManager.getEntityDimensions( entityId ),
								overlayEntityId     = overlayEntityMap[ entityId ]
			
							if( overlayEntityId  ) {
								//overlay for entity already exists, so update it
			
								//bypass updateComponent mechanic for updating the transform component on purpose
								//don't to this within normal systems
								var transformOverlay = this.transforms[ overlayEntityId ]
								vec2.copy( transformOverlay.translation, transform.worldTranslation )
								transformOverlay.rotation = 0
			
								var text, color, lineWidth
			
								if( this.selectedEntity == entityId ) {
									text        = (name) ? name.name : entityId
									color       = [0, 1, 0]
									lineWidth   = 3
								} else {
									text    = ''
									color   = [1, 0 ,1]
									lineWidth = 1
								}
			
			
								entityManager.updateComponent( overlayEntityMap[ entityId ], 'spell.component.2d.graphics.shape.rectangle', {
									'lineColor': color,
									'height': entityDimensions[ 1 ],
									'width': entityDimensions[ 0 ]
								})
			
			
								entityManager.updateComponent( overlayEntityMap[ entityId ], 'spell.component.2d.graphics.textAppearance', {
									'text': text
								})
							}
							else {
			
								var overlayEntityId = entityManager.createEntity({
									'config': {
										'spell.component.2d.transform': {
											'translation': transform.worldTranslation
										},
										'spell.component.2d.graphics.textAppearance': {
											'text': ''
										},
										'spell.component.visualObject': {
											'layer': 99999990
										},
										'spell.component.2d.graphics.shape.rectangle': {
											'color': [1, 0, 1],
											'height': entityDimensions[ 1 ],
											'width': entityDimensions[ 0 ]
										}
									}
								})
			
								overlayEntityMap[ entityId ] = overlayEntityId
							}
			
						}
			
						//now remove all overlay entites that are not needed anymore
						var currentlyOverlayedEntites   = _.keys( overlayEntityMap),
							overlaysThatNeedRemovalList = _.difference( currentlyOverlayedEntites, matchedEntites )
			
						for( var i= 0,length=overlaysThatNeedRemovalList.length; i<length; i++) {
							var entityId = overlaysThatNeedRemovalList[ i ]
			
							entityManager.removeEntity( overlayEntityMap[ entityId ] )
							delete overlayEntityMap[ entityId ]
			
							if( entityId == this.selectedEntity && !this.isDragging ) {
								//if we removed the selectedEntity and we're not dragging it, deselect it
								selectEntity.call( this, null )
							}
						}
			
						return overlayEntityMap
					}
			
					var highlightEntitiesAtPosition = function( worldPosition ) {
			
						if( this.isDragging ) {
							//Don't highlight entites while dragging
							this.matchedEntities.length = 0
						} else {
							//find all entities that match with the current cursor position
							this.matchedEntities = _.filter(
								_.keys( this.transforms ),
								_.bind(
									isPointWithinEntity,
									this,
									worldPosition
								)
							)
						}
			
						//highlight the found entities with overlays
						syncOverlayEntitesWithMatchedEntites.call(
							this,
							this.overlayEntityMap,
							this.matchedEntities
						)
					}
			
					var sendTransformToSpellEd = function( entityId ) {
						if(!this.transforms[ entityId ]) {
							return false
						}
			
						this.spell.entityManager.updateWorldTransform( entityId )
						this.isDirty = false
			
						this.spell.sendMessageToEditor(
							'spelled.entity.update', {
							id: entityId,
							componentId: 'spell.component.2d.transform',
							config: {
								translation: this.transforms[ entityId ].translation
							}
						})
			
						if(
							this.spell.entityManager.hasComponent(
							entityId,
							'spellStaged.jumpAndRun.platform'
							) ) {
			
							this.spell.entityManager.updateComponent(
								entityId,
								'spellStaged.jumpAndRun.platform',
								{
									origin: [
										this.transforms[ entityId ].translation[0],
										this.transforms[ entityId ].translation[1]
									],
									offset: 0
								}
							)
						}
			
						if(
							this.spell.entityManager.hasComponent(
								entityId,
								'spellStaged.jumpAndRun.enemy'
							) ) {
			
							this.spell.entityManager.updateComponent(
								entityId,
								'spellStaged.jumpAndRun.enemy',
								{
									origin: [
										this.transforms[ entityId ].translation[0],
										this.transforms[ entityId ].translation[1]
									],
									offset: 0
								}
							)
						}
			
			
			
					}
			
					var startDragging = function( entityId, cursorPosition ) {
			
						var isMoveable  = this.editorSystem.prototype.isMoveable.call( this.editorSystem, entityId ),
							isCloneable = this.editorSystem.prototype.isCloneable.call( this.editorSystem, entityId )
			
						if(!isMoveable) {
							return false
						}
			
			
						if( isCloneable === true && this.editorSystem.commandMode === true) {
							//if STRG is pressed while the dragging starts, clone the entity
			
							this.spell.sendMessageToEditor(
								'spelled.debug.entity.clone',
								{
									id: entityId
								}
							)
						}
			
						this.isDragging = true
			
						var transform = this.transforms[ entityId ]
			
						if(!this.dragCursorOffset) {
							this.dragCursorOffset = vec2.create()
							vec2.copy( this.dragCursorOffset, this.editorSystem.cursorWorldPosition )
						}
			
						if(!this.dragEntityOffset && transform) {
							this.dragEntityOffset = vec2.create()
							vec2.copy( this.dragEntityOffset, transform.translation )
						}
					}
			
					var stopDragging = function( entityId, cursorPosition ) {
						this.isDragging = false
						this.dragCursorOffset = null
						this.dragEntityOffset = null
			
						if(this.isDirty) {
							sendTransformToSpellEd.call( this, this.selectedEntity )
							selectEntity.call( this, null )
						}
					}
			
					var cancelSelection = function() {
						selectEntity.call( this, null )
						this.matchedEntities.length = 0
			
						syncOverlayEntitesWithMatchedEntites.call( this, this.overlayEntityMap, this.matchedEntities)
					}
			
					var updateEntityByWorldPosition = function( entityManager, entityId, cursorPosition ) {
			
						if( !this.transforms[ entityId ] ) {
							//no transform available for this object. This can happen if it was removed during dragging.
							//Ignore this update
							return
						}
			
						var transform        = this.transforms[ entityId ],
							distance         = vec2.create( ),
							worldPosition    = transform.translation
			
						vec2.subtract( distance, this.dragCursorOffset, cursorPosition )
						vec2.subtract( worldPosition, this.dragEntityOffset, distance )
			
						updateEntity.call( this, entityManager, entityId, worldPosition )
					}
			
					var updateEntityByRelativeOffset = function( entityManager, entityId, offset ) {
						var transform           = this.transforms[ entityId ],
							currentTranslation  = transform.translation
			
						vec2.add( currentTranslation, currentTranslation, offset )
			
						updateEntity.call(this, entityManager, entityId, currentTranslation)
						sendTransformToSpellEd.call( this, entityId )
					}
			
					var updateEntity = function( entityManager, entityId, newTranslation ) {
						this.isDirty = true
			
						var transform           = this.transforms[ entityId ],
							overlayEntityId     = this.overlayEntityMap[ entityId ],
							body                = this.bodies[ entityId ]
			
						vec2.copy( transform.translation, newTranslation )
			
						if( overlayEntityId && this.transforms[ overlayEntityId ]) {
							vec2.copy( this.transforms[ overlayEntityId ].translation, newTranslation )
						}
			
						entityManager.updateWorldTransform( entityId )
			
						//if this object has a phyics body, reposition the physics body
						if( body && this.spell.box2dWorlds && this.spell.box2dWorlds.main ) {
							this.spell.box2dWorlds.main.setPosition( entityId, newTranslation )
						}
					}
			
					var toggleThroughMatchedEntites = function( matchedEntites, activeEntityId ) {
						var index = _.indexOf( matchedEntites, activeEntityId )
			
						if(index === -1) {
							index = 0
						} else {
							index = (index + 1) % matchedEntites.length
						}
			
						selectEntity.call( this, matchedEntites[ index ] )
					}
			
					var interactiveEditorSystem = null
			
					var selectEntity = function( entityId ) {
						this.selectedEntity = entityId
						this.editorSystem.prototype.setSelectedEntity.call( this.editorSystem, entityId )
					}
			
					var entityMover = function(spell, editorSystem) {
						this.editorSystem       = editorSystem
			
						/**
						 * Map entity => corresponding overlay entity
						 * @type {Object}
						 */
						this.overlayEntityMap         = {}
			
						/**
						 * id of the currently selected entity
						 * @type {string}
						 */
						this.selectedEntity           = null
			
						/**
						 * Is corrently a drag going on?
						 * @type {null}
						 */
						this.isDragging               = false
			
						/**
						 * Do we have unsaved data?
						 * @type {Boolean}
						 */
						this.isDirty                  = false
			
						/**
						 * List of entities which match for the current cursor (through all layers)
						 * @type {Array}
						 */
						this.matchedEntities          = []
			
						/**
						 * While an entity is dragged, we remember the offset from the dragstart
						 * @type {null}
						 */
						this.dragCursorOffset         = null
			
						/**
						 * Remember the origin of the entity
						 * @type {null}
						 */
						this.dragEntityOffset         = null
			
			
					}
			
					entityMover.prototype = {
			
						init: function( spell, editorSystem ) {
							this.spell                  = spell
							this.bodies                 = editorSystem.bodies
							this.transforms             = editorSystem.transforms
							this.appearances            = editorSystem.appearances
							this.animatedAppearances    = editorSystem.animatedAppearances
							this.editorConfigurations   = editorSystem.editorConfigurations
							this.metadata               = editorSystem.metadata
						},
			
						activate: function( spell, editorSystem, event ) {
			
						},
			
						deactivate: function( spell, editorSystem ) {
							//remove all overlay entities
							for( var entityId in this.overlayEntityMap ) {
								spell.entityManager.removeEntity( this.overlayEntityMap[ entityId ] )
								delete this.overlayEntityMap[ entityId ]
							}
						},
			
						process: function( spell, editorSystem, timeInMs, deltaTimeInMs) {
							if( this.editorSystem.cursorWorldPosition ) {
								highlightEntitiesAtPosition.call( this, this.editorSystem.cursorWorldPosition )
							}
						},
			
						pointerDown: function( spell, editorSystem, event ) {
							if( event.button != 0 ) {
								return
							}
			
							if(!this.selectedEntity && this.matchedEntities.length > 0 ) {
								//if no entity is selected and a drag is going on
								selectEntity.call( this, this.matchedEntities[ this.matchedEntities.length - 1 ] )
							}
			
							if( this.selectedEntity ) {
								startDragging.call( this, this.selectedEntity, event.position )
							}
						},
			
						pointerUp: function( spell, editorSystem, event ) {
							if( event.button == 0 && this.isDragging ) {
								stopDragging.call( this, this.selectedEntity, event.position )
							}
						},
			
						pointerMove: function( spell, editorSystem, event ) {
			
							if( this.selectedEntity && this.isDragging ) {
								updateEntityByWorldPosition.call( this, spell.entityManager, this.selectedEntity, this.editorSystem.cursorWorldPosition )
							}
						},
			
						keyDown: function( spell, editorSystem, event ) {
							var movementAllowed = this.editorSystem.prototype.isMoveable.call( this.editorSystem, this.selectedEntity ),
								entityManager   = spell.entityManager,
								canMoveEntity   = this.selectedEntity && movementAllowed && this.editorSystem.commandMode === true
			
							if(event.keyCode == 27 && this.selectedEntity ) {
								//ESC cancels selection
								cancelSelection.call( this )
			
							} else if( event.keyCode == 9 && this.matchedEntities.length > 0) {
								//TAB toggles through selected entity
								toggleThroughMatchedEntites.call(this, this.matchedEntities, this.selectedEntity )
			
							} else if( event.keyCode == 37 && canMoveEntity ) {
								//Left arrow moves the selected entity one pixel to the left
								updateEntityByRelativeOffset.call( this, entityManager, this.selectedEntity, [-1, 0])
			
							} else if( event.keyCode == 38 && canMoveEntity ) {
								//top arrow moves the selected entity one pixel up
								updateEntityByRelativeOffset.call( this, entityManager, this.selectedEntity, [0, 1])
			
							} else if( event.keyCode == 39 && canMoveEntity ) {
								//right arrow moves the selected entity one pixel to the right
								updateEntityByRelativeOffset.call( this, entityManager, this.selectedEntity, [1, 0])
			
							} else if( event.keyCode == 40 && canMoveEntity ) {
								//down arrow moves the selected entity one pixel down
								updateEntityByRelativeOffset.call( this, entityManager, this.selectedEntity, [0, -1])
			
							}
						},
			
						keyUp: function( spell, editorSystem, event ) {
			
						}
					}
			
					return entityMover
				}
			)
			
			define("spell/script/editor/entityRemover",
				[
					'spell/functions'
				],
				function(
					_
					) {
					"use strict";
			
					var entityRemover = function(spell, editorSystem) {
					}
			
					entityRemover.prototype = {
						keyDown: function( spell, editorSystem, event ) {
							var KEY        = spell.inputManager.KEY,
								selectedEntityId  = editorSystem.selectedEntity
			
							if( !selectedEntityId ) {
								return
							}
			
							var isRemovable  = editorSystem.prototype.isRemovable.call( editorSystem, selectedEntityId )
			
			
								if( isRemovable &&
									(
										event.keyCode === KEY.DELETE ||
										event.keyCode === KEY.BACKSPACE
									)
								) {
			
			
								spell.sendMessageToEditor(
									'spelled.debug.entity.remove',
									{
										id: selectedEntityId
									}
								)
			
							}
						}
			
					}
			
					return entityRemover
				})
			
			define("spell/script/editor/selectedEntityHighlighter",
				[
					'spell/math/vec2',
					'spell/math/mat3',
					'spell/functions'
				],
				function(
					vec2,
					mat3,
					_
					) {
					"use strict";
			
					var RECTANGLE_COMPONENT_ID = 'spell.component.2d.graphics.shape.rectangle'
			
					var entityHighlighter = function(spell, editorSystem) {
					}
			
					entityHighlighter.prototype = {
						process: function( spell, editorSystem, timeInMs, deltaTimeInMs) {
							return
							var entityManager       = spell.entityManager,
								selectedEntityId    = editorSystem.selectedEntity
			
			
							if( selectedEntityId ) {
			
								var rectangleConfig = {
									'lineColor': [1, 0, 0],
									'lineWidth': 3
								}
			
								if( !entityManager.hasComponent( selectedEntityId, RECTANGLE_COMPONENT_ID) ) {
			
									entityManager.addComponent( selectedEntityId, RECTANGLE_COMPONENT_ID, rectangleConfig)
			
								} else {
									entityManager.updateComponent( selectedEntityId, RECTANGLE_COMPONENT_ID, rectangleConfig)
								}
							}
						}
					}
			
					return entityHighlighter
			
			
				})
			define(
				'spell/script/editor/tilemapEditor',
				[
					'spell/math/vec2',
					'spell/math/mat3',
			        'spell/math/util',
			
					'spell/functions'
				],
				function(
					vec2,
					mat3,
			        mathUtil,
					_
					) {
					'use strict'
			
					var STATE_INACTIVE      = 0,
						STATE_SELECT_TILE   = 1,
						STATE_READY_TO_DRAW = 2,
						STATE_DRAW_TILE     = 3
			
			        var worldToLocalMatrix = mat3.create()
			
			        var tilemapEditor = function(spell, editorSystem) {
						this.state              = STATE_INACTIVE
						this.transforms         = editorSystem.transforms
						this.tilemaps           = editorSystem.tilemaps
			
						/**
						 * Reference to the spell object
						 */
						this.spell                          = spell
			
						/**
						 * Reference to the editorSystem
						 */
						this.editorSystem                   = editorSystem
			
						/**
						 * Entity of the tilemap that is currently being edited
						 */
						this.currentTilemap                 = null
			
						/**
						 * The cell the cursor is pointing to atm
						 * @type {vec2}
						 */
						this.currentOffset                  = null
			
						/**
						 * The currently selected frame index
						 * @type {number}
						 */
						this.currentFrameIndex              = null
			
						/**
						 * Mapping frameindex => entityId for the selection overlay
						 * @type {Object}
						 */
						this.tilemapSelectionMap            = {}
			
						/**
						 * Entity if of the entity for the background in the selection screen
						 */
						this.tilemapSelectionBackground     = null
			
						/**
						 * EntityId of the entity that is currently highlighted
						 */
						this.tilemapSelectionHighlighted    = null
			
						/**
						 * The entityId of the selection cursor
						 * @type {null}
						 */
						this.tilemapSelectionCursor         = null
					}
			
					var tmpVec2 = vec2.create()
			
					//private functions
					var isPointWithinEntity = function ( worldPosition, entityId ) {
						var transform = this.transforms[ entityId ],
							entityDimensions = this.spell.entityManager.getEntityDimensions( entityId )
			
						return mathUtil.isPointInRect( worldPosition, transform.worldTranslation, entityDimensions[ 0 ], entityDimensions[ 1 ], 0 )
			
					}
			
					var destroyTilemapSelectionEntities = function( exceptThisEntityId ) {
						var entityManager = this.spell.entityManager
			
						if( this.tilemapSelectionBackground !== null ) {
							entityManager.removeEntity( this.tilemapSelectionBackground )
							this.tilemapSelectionBackground = null
						}
			
						for( var frameIndex in this.tilemapSelectionMap ) {
							var entityId = this.tilemapSelectionMap[ frameIndex ]
			
							if( !exceptThisEntityId || exceptThisEntityId !== entityId ) {
								entityManager.removeEntity( entityId )
							}
						}
			
						if (this.tilemapSelectionCursor !== null && this.tilemapSelectionCursor !== exceptThisEntityId) {
							entityManager.removeEntity(this.tilemapSelectionCursor)
						}
						this.tilemapSelectionMap = {}
					}
			
					var alignToGrid = function( entityId, worldPosition, tilemap, tilemapTransform ) {
						var entityManager       = this.spell.entityManager,
							tilemap             = this.tilemaps[ this.currentTilemap ],
							tilemapTransform    = this.transforms[ this.currentTilemap ],
							tilemapDimensions   = entityManager.getEntityDimensions( this.currentTilemap ),
							tilemapTranslation  = tilemapTransform.worldTranslation,
							frameDimensions     = tilemap.asset.spriteSheet.frameDimensions,
							currentOffset       = null
			
						if(
							mathUtil.isPointInRect( worldPosition, tilemapTranslation, tilemapDimensions[ 0 ], tilemapDimensions[ 1 ], 0 )
						) {
			
			                mat3.invert( worldToLocalMatrix, tilemapTransform.worldMatrix )
			
			                //convert worldposition to coordinates which are local to the tilemaps origin
							vec2.transformMat3( tmpVec2, worldPosition, worldToLocalMatrix )
			
							if ( entityManager.hasComponent(entityId, 'spell.component.2d.graphics.shape.rectangle') ) {
								entityManager.removeComponent(entityId, 'spell.component.2d.graphics.shape.rectangle')
							}
			
							var offsetX         = Math.floor( tmpVec2[ 0 ] / frameDimensions[ 0 ]),
								offsetY         = Math.floor( tmpVec2[ 1 ] / frameDimensions[ 1 ]),
								currentOffset   = [ offsetX, offsetY ]
			
							//transform the grid aligned local coordinates to world coordinates again
							tmpVec2[ 0 ] = offsetX * frameDimensions[ 0 ] + frameDimensions[ 0 ] / 2
							tmpVec2[ 1 ] = offsetY * frameDimensions[ 1 ] + frameDimensions[ 1 ] / 2
							vec2.transformMat3( tmpVec2, tmpVec2, tilemapTransform.worldMatrix )
			
							entityManager.updateComponent( entityId, 'spell.component.2d.transform', {
								translation: tmpVec2
							})
			
			
						} else {
							//it's not placeable here
							if( !entityManager.hasComponent(entityId, 'spell.component.2d.graphics.shape.rectangle') ) {
			
								entityManager.addComponent(entityId, 'spell.component.2d.graphics.shape.rectangle',
									{
										'lineColor': [1, 0, 0],
										'lineWidth': 3,
										'width': frameDimensions[0],
										'height': frameDimensions[1]
									})
							}
			
							entityManager.updateComponent(entityId, 'spell.component.2d.transform', {
								translation: worldPosition
							})
			
						}
			
						entityManager.updateWorldTransform( entityId )
			
						return currentOffset
					}
			
					var updateTilemap = function( offset, frameIndex ) {
			
						var tilemap           = this.tilemaps[ this.currentTilemap ],
							asset             = tilemap.asset,
							tilemapDimensions = asset.tilemapDimensions,
							tilemapData       = asset.tilemapData,
							maxY              = parseInt(tilemapDimensions[ 1 ],10) - 1,
							normalizedOffsetX = offset[ 0 ] + Math.floor(tilemapDimensions[ 0 ] / 2),
							normalizedOffsetY = maxY - (offset[ 1 ] + Math.floor(maxY / 2) + 1)
			
						//make sure the tilemapData structure is initialized
						for (var y=0; y < tilemapDimensions[1].length; y++) {
							for (var x=0; x < tilemapDimensions[0].length; x++) {
								if (tilemapData[ y ][ x ] === undefined) {
									tilemapData[ y ][ x ] = null
								}
							}
						}
			
						if (frameIndex == 9999) {
							frameIndex = null
			
						} else {
							frameIndex = parseInt(frameIndex, 10)
						}
			
						tilemapData[ normalizedOffsetY ][ normalizedOffsetX ] = frameIndex
					}
			
					var sendChangedAssetDataToEditor = function() {
						var tilemap           = this.tilemaps[ this.currentTilemap ],
							asset             = tilemap.asset,
							data              = {
								id: tilemap.assetId,
								config: {
									'width':            asset.config['width'],
									'height':           asset.config['height'],
									'tileLayerData':    asset.tilemapData
								},
								assetId: asset.spriteSheet.assetId
							}
			
						this.spell.sendMessageToEditor(
							'spelled.debug.library.updateAsset', data
						)
					}
			
					/**
					 * Gets called when tile editing starts for a selectedEntity
					 */
					var beginTileEditing = function() {
						var editorSystem        = this.editorSystem,
							selectedEntityId    = editorSystem.selectedEntity
			
						editorSystem.prototype.deactivatePlugin.call( editorSystem, 'entityMover' )
			
						this.currentTilemap = selectedEntityId
						this.state          = STATE_SELECT_TILE
			
						destroyTilemapSelectionEntities.call( this )
			
						showTilemapSelector.call( this, editorSystem.cursorWorldPosition, this.tilemaps[ selectedEntityId ] )
					}
			
					/**
					 * Gets calles when tile editing ends for a selectedEntity
					 */
					var endTileEditing = function() {
						var editorSystem        = this.editorSystem,
							selectedEntityId    = editorSystem.selectedEntity
			
						this.state = STATE_INACTIVE
						destroyTilemapSelectionEntities.call( this )
			
						editorSystem.prototype.activatePlugin.call( editorSystem, 'entityMover' )
			
					}
			
			
					var showTilemapSelector = function( cursorWorldPosition, tilemapAsset ) {
						var entityManager               = this.spell.entityManager,
							spriteSheetAssetId          = tilemapAsset.asset.spriteSheet.assetId,
							frameDimensions             = tilemapAsset.asset.spriteSheet.frameDimensions,
							numFrames                   = tilemapAsset.asset.spriteSheet.numFrames,
							numFrames                   = numFrames + 1 //we add one frame for the delete icon
			
						//present a nice quadratic selection menu for the tiles
						var framesPerRow = Math.floor( Math.sqrt(numFrames) )
			
						var offsetX     = cursorWorldPosition[ 0 ],
							offsetY     = cursorWorldPosition[ 1 ],
							frameWidth  = framesPerRow * frameDimensions[ 0 ],
							frameHeight = framesPerRow * frameDimensions[ 1 ]
			
						//draw a background for the tile selection menu
						this.tilemapSelectionBackground = entityManager.createEntity({
							'config': {
								'spell.component.2d.transform': {
									'translation': [
										offsetX + frameWidth / 2 - frameDimensions[ 0 ] / 2,
										offsetY - frameHeight / 2 + frameDimensions[ 1 ] / 2
									]
								},
								'spell.component.visualObject': {
									'opacity': 0.7,
									'layer': 99999997
								},
								'spell.component.2d.graphics.shape.rectangle': {
									'fill': true,
									'fillColor': [0.35, 0.35, 0.35],
									'lineColor': [0.5, 0.5, 0.5],
									'lineWidth': 3,
									'width': frameWidth + 10,
									'height': frameHeight + 10
								}
							}
						})
			
						//draw every tile of the tileset
						this.tilemapSelectionMap = {}
						for (var x=0; x<numFrames-1; x++) {
							this.tilemapSelectionMap[ x ] = entityManager.createEntity({
								'config': {
									'spell.component.2d.transform': {
										'translation': [ offsetX, offsetY ]
									},
									'spell.component.2d.graphics.spriteSheetAppearance': {
										'assetId': spriteSheetAssetId,
										'drawAllFrames': false,
										'frames': [ x ]
									},
									'spell.component.2d.graphics.geometry.quad': {
										'dimensions': [ frameDimensions[ 0 ], frameDimensions[ 1 ] ]
									},
									'spell.component.visualObject': {
										'layer': 99999998
									}
								}
							})
			
							offsetX += frameDimensions[ 0 ]
			
							if (x % framesPerRow === framesPerRow-1) {
								offsetY -= frameDimensions[ 1 ]
								offsetX = cursorWorldPosition[ 0 ]
							}
						}
			
			
						this.tilemapSelectionMap[9999] = entityManager.createEntity({
							'config': {
								'spell.component.2d.transform': {
									'translation': [ offsetX, offsetY ]
								},
								'spell.component.2d.graphics.appearance': {
									'assetId': 'appearance:spell.remove'
								},
								'spell.component.2d.graphics.geometry.quad': {
									'dimensions': [ frameDimensions[ 0 ], frameDimensions[ 1 ] ]
								},
								'spell.component.visualObject': {
									'layer': 99999998
								}
							}
						})
			
					}
			
					//public functions
					tilemapEditor.prototype = {
			
						init: function( spell, editorSystem ) {
			
						},
			
						activate: function( spell, editorSystem ) {
			
						},
			
						deactivate: function( spell, editorSystem ) {
			
						},
			
						process: function ( spell, editorSystem, timeInMs, deltaTimeInMs) {
							var entityManager = spell.entityManager
			
							if( this.state === STATE_SELECT_TILE ) {
								// find all entities that match with the current cursor position
								var matchedEntities = _.filter(
									_.values( this.tilemapSelectionMap ),
									_.bind(
										isPointWithinEntity,
										this,
										editorSystem.cursorWorldPosition
									)
								)
			
								// clear all rects
								_.each(
									this.tilemapSelectionMap,
									function( entityId, frameIndex ) {
										entityManager.removeComponent( entityId, 'spell.component.2d.graphics.shape.rectangle' )
									}
								)
			
								this.tilemapSelectionHighlighted = null
								if( matchedEntities.length > 0 ) {
									this.tilemapSelectionHighlighted = matchedEntities[ 0 ]
			
									var frameDimensions = this.tilemaps[ this.currentTilemap ].asset.spriteSheet.frameDimensions
			
									if (!entityManager.hasComponent(this.tilemapSelectionHighlighted, 'spell.component.2d.graphics.shape.rectangle')) {
										entityManager.addComponent(this.tilemapSelectionHighlighted, 'spell.component.2d.graphics.shape.rectangle',
											{
												'lineColor': [0, 1, 0],
												'lineWidth': 3,
												'width': frameDimensions[0],
												'height': frameDimensions[1]
											})
									}
			
								}
							}
			
						},
			
						keyDown: function( spell, editorSystem, event ) {
							var KEY        = spell.inputManager.KEY,
								selectedEntityId  = editorSystem.selectedEntity
			
							if( event.keyCode === KEY.SPACE && selectedEntityId !== null && this.tilemaps[ selectedEntityId ] ) {
			
								beginTileEditing.call( this )
			
							} else if (
								event.keyCode === KEY.ESCAPE &&
								(
									this.state === STATE_SELECT_TILE ||
									this.state === STATE_READY_TO_DRAW ||
									this.state === STATE_DRAW_TILE
								)
							) {
			
								endTileEditing.call( this )
							}
			
						},
			
						pointerDown: function( spell, editorSystem, event ) {
							var entityManager = spell.entityManager
			
							if(event.button != 0) {
								//only respond to left mouseclicks
								return
							}
			
							if( this.state === STATE_SELECT_TILE && this.tilemapSelectionHighlighted !== null ) {
			
								this.tilemapSelectionCursor         = this.tilemapSelectionHighlighted
								this.tilemapSelectionHighlighted    = null
			
								//find the current selected frame index
								for(var frameIndex in this.tilemapSelectionMap) {
									var entityId = this.tilemapSelectionMap[ frameIndex ]
			
									if(entityId === this.tilemapSelectionCursor ) {
										this.currentFrameIndex = frameIndex
										break
									}
								}
			
								destroyTilemapSelectionEntities.call(this, this.tilemapSelectionCursor )
			
								entityManager.removeComponent( this.tilemapSelectionCursor, 'spell.component.2d.graphics.shape.rectangle' )
			
								this.state = STATE_READY_TO_DRAW
			
							} else if( this.state === STATE_READY_TO_DRAW && this.tilemapSelectionCursor !== null && this.currentOffset !== null ) {
								this.state = STATE_DRAW_TILE
								updateTilemap.call( this, this.currentOffset, this.currentFrameIndex )
							}
						},
			
						pointerUp: function( spell, editorSystem, event ) {
			
							if(this.state === STATE_DRAW_TILE) {
								this.currentOffset                  = null
								this.state = STATE_READY_TO_DRAW
			
								sendChangedAssetDataToEditor.call( this )
							}
						},
			
			
						pointerMove: function( spell, editorSystem, event ) {
							var entityManager = spell.entityManager
			
							if(this.state === STATE_READY_TO_DRAW && this.tilemapSelectionCursor !== null && this.currentTilemap !== null) {
								this.currentOffset = alignToGrid.call(
									this,
									this.tilemapSelectionCursor,
									editorSystem.cursorWorldPosition)
							} else if( this.state === STATE_DRAW_TILE ) {
								this.currentOffset = alignToGrid.call(
									this,
									this.tilemapSelectionCursor,
									editorSystem.cursorWorldPosition)
			
								if(this.tilemapSelectionCursor !== null && this.currentOffset !== null) {
									updateTilemap.call( this, this.currentOffset, this.currentFrameIndex )
								}
							}
						}
					}
			
					return tilemapEditor
			
				})
			
			define(
				'spell/script/logStatistics',
				[
					'spell/shared/util/platform/PlatformKit'
				],
				function(
					PlatformKit
				) {
					'use strict'
			
			
					var platformDetails = PlatformKit.platformDetails
			
					var rpcBuffer = []
			
					var sendLogRequest = function( url, data ) {
						PlatformKit.network.performHttpRequest( 'POST', url, data )
					}
			
					var createLogData = function( spell, sceneId, clientId, payload ) {
						var renderingContext     = spell.renderingContext,
							configurationManager = spell.configurationManager
			
						return PlatformKit.jsonCoder.encode( {
							renderingBackEnd : renderingContext.getConfiguration().type,
							renderingInfo    : renderingContext.getConfiguration().info,
							averageFrameTime : spell.statisticsManager.getAverageTickTime(),
							uuid             : clientId,
							scene_id         : sceneId,
							projectId        : configurationManager.getValue( 'projectId' ),
							screenHeight     : platformDetails.getScreenHeight(),
							screenWidth      : platformDetails.getScreenWidth(),
							device           : platformDetails.getDevice(),
							os               : platformDetails.getOS(),
							payload          : payload,
							platform         : platformDetails.getPlatform(),
							platformAdapter  : platformDetails.getPlatformAdapter(),
							language         : configurationManager.getValue( 'currentLanguage' )
						} )
					}
			
					var processBuffer = function( spell, clientId, buffer ) {
						var rpc = buffer.shift()
			
						while( rpc ) {
							sendLogRequest(
								rpc.url,
								{
									type : rpc.messageType,
									data : createLogData( spell, rpc.sceneId, clientId, rpc.payload )
								}
							)
			
							rpc = buffer.shift()
						}
					}
			
					return function( spell, sceneId, url, messageType, payload ) {
						var clientId = spell.storage.get( 'clientId' )
			
						if( !clientId ) {
							rpcBuffer.push( { sceneId : sceneId, url : url, messageType: messageType, payload : payload } )
			
						} else {
							processBuffer( spell, clientId, rpcBuffer )
			
							sendLogRequest(
								url,
								{
									type : messageType,
									data : createLogData( spell, sceneId, clientId, payload )
								}
							)
						}
					}
				}
			)
			
			define(
				'Scene1',
				[
					'spell/functions'
				],
				function(
					_
				) {
					'use strict'
					
					
					return {
						init : function( spell, sceneConfig ) {
							spell.entityManager.createEntities( sceneConfig.entities )
						},
						destroy : function( spell, sceneConfig ) {}
					}
				}
			)
			
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
					
					var ballsAmount = 10
					
					
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
							var randomNumber  = this.randomNumber,
								entityManager = spell.entityManager,
								world         = spell.box2dWorlds.main				
			
							for( var i = 0; i < ballsAmount; i++ ) {
			
								var id = entityManager.createEntity( { 
									entityTemplateId: 'Benchmarks.entities.Ball',
									 config: {
										"spell.component.2d.transform": {
											"translation": [ randomNumber(), randomNumber() ]
			    				    	}   				    	
									}						
								})		
								
								world.setVelocity( id, [ randomNumber(), randomNumber() ] )
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
			
			/**
			 * @class audio
			 * @singleton
			 */
			
			define(
				'spell/system/audio',
				[
					'spell/Defines',
					'spell/Events'
				],
				function(
					Defines,
					Events
				) {
					'use strict'
			
			
					var playSound = function( entityManager, audioContext, id, soundEmitter ) {
						if( soundEmitter.mute ||
							audioContext.isAllMuted() ) {
			
							audioContext.mute( id )
						}
			
						if( !soundEmitter.play ) {
							audioContext.play( soundEmitter.asset.resource, id, soundEmitter.volume, soundEmitter.loop )
			
							soundEmitter.play = true
			
						} else {
							audioContext.setLoop( id, soundEmitter.loop )
							audioContext.setVolume( id, soundEmitter.volume )
						}
					}
			
			
					/**
					 * Creates an instance of the system.
					 *
					 * @constructor
					 * @param {Object} [spell] The spell object.
					 */
					var audio = function( spell ) {
						this.soundEmitterUpdatedHandler = null
					}
			
					audio.prototype = {
						/**
					 	 * Gets called when the system is created.
					 	 *
					 	 * @param {Object} [spell] The spell object.
						 */
						init: function( spell ) {
							var audioContext  = spell.audioContext,
								entityManager = spell.entityManager,
								eventManager  = spell.eventManager
			
							this.soundEmitterUpdatedHandler = function( soundEmitter, id ) {
								playSound( entityManager, audioContext, id, soundEmitter )
							}
			
							eventManager.subscribe( [ Events.COMPONENT_CREATED, Defines.SOUND_EMITTER_COMPONENT_ID ], this.soundEmitterUpdatedHandler )
							eventManager.subscribe( [ Events.COMPONENT_UPDATED, Defines.SOUND_EMITTER_COMPONENT_ID ], this.soundEmitterUpdatedHandler )
						},
			
						/**
					 	 * Gets called when the system is destroyed.
					 	 *
					 	 * @param {Object} [spell] The spell object.
						 */
						destroy: function( spell ) {
							var eventManager = spell.eventManager
			
							eventManager.unsubscribe( [ Events.COMPONENT_CREATED, Defines.SOUND_EMITTER_COMPONENT_ID ], this.soundEmitterUpdatedHandler )
							eventManager.unsubscribe( [ Events.COMPONENT_UPDATED, Defines.SOUND_EMITTER_COMPONENT_ID ], this.soundEmitterUpdatedHandler )
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
							var audioContext  = spell.audioContext,
								soundEmitters = this.soundEmitters
			
							for( var id in soundEmitters ) {
								audioContext.stop( id )
							}
			
							audioContext.tick()
						},
			
						/**
					 	 * Gets called to trigger the processing of game state.
					 	 *
						 * @param {Object} [spell] The spell object.
						 * @param {Object} [timeInMs] The current time in ms.
						 * @param {Object} [deltaTimeInMs] The elapsed time in ms.
						 */
						process: function( spell, timeInMs, deltaTimeInMs ) {
							spell.audioContext.tick()
						}
					}
			
					return audio
				}
			)
			
			/**
			 * @class spell.system.cameraMover
			 * @singleton
			 */
			
			define(
				'spell/system/cameraMover',
				function() {
					'use strict'
			
			
					/**
					 * Creates an instance of the system.
					 *
					 * @constructor
					 * @param {Object} [spell] The spell object.
					 */
					var cameraMover = function( spell ) {
						this.cameraIdToFollowEntityName = {}
					}
			
					cameraMover.prototype = {
						/**
					 	 * Gets called when the system is created.
					 	 *
					 	 * @param {Object} [spell] The spell object.
						 */
						init: function( spell ) {
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
							var cameraIdToFollowEntityName = this.cameraIdToFollowEntityName,
								cameraMovements            = this.cameraMovements,
								transforms                 = this.transforms
			
							for( var cameraId in cameraMovements ) {
								var cameraMovement    = cameraMovements[ cameraId ],
									cameraTranslation = transforms[ cameraId ].translation,
									followEntityName  = cameraIdToFollowEntityName[ cameraId ],
									followEntityId    = cameraMovement.followEntityId
			
								if( cameraMovement.followEntityName &&
									cameraMovement.followEntityName !== followEntityName ) {
			
									// the camera follows another entity now
									followEntityName = cameraMovement.followEntityName
									followEntityId = spell.entityManager.getEntityIdsByName( followEntityName )[ 0 ]
			
									if( followEntityId ) {
										cameraMovement.followEntityId = followEntityId
										cameraIdToFollowEntityName[ cameraId ] = followEntityName
									}
								}
			
								if( followEntityId ) {
									var entityTranslation = transforms[ followEntityId ].translation
			
									if( !cameraTranslation || !entityTranslation ) {
										throw 'Either the camera or the entity ' + followEntityName + ' does not have a transform component.'
									}
			
									cameraTranslation[ 0 ] = entityTranslation[ 0 ]
									cameraTranslation[ 1 ] = entityTranslation[ 1 ]
								}
			
								if( cameraMovement.obeyMinMax ) {
									var minX = cameraMovement.minX,
										maxX = cameraMovement.maxX,
										minY = cameraMovement.minY,
										maxY = cameraMovement.maxY
			
				 					if( cameraTranslation[ 0 ] < minX ) {
								    	cameraTranslation[ 0 ] = minX
								    }
			
								    if( cameraTranslation[ 0 ] > maxX ) {
								    	cameraTranslation[ 0 ] = maxX
								    }
			
								    if( cameraTranslation[ 1 ] < minY ) {
								    	cameraTranslation[ 1 ] = minY
								    }
			
								    if( cameraTranslation[ 1 ] > maxY ) {
								    	cameraTranslation[ 1 ] = maxY
								    }
								}
							}
						}
					}
			
					return cameraMover
				}
			)
			
			define(
				'spell/system/clearKeyInput',
				function() {
					'use strict'
			
			
					/**
					 * Update the actor entities action component with the player input
					 *
					 * @param spell
					 * @param timeInMs
					 * @param deltaTimeInMs
					 */
					var process = function( spell, timeInMs, deltaTimeInMs ) {
						spell.inputManager.clearInputEvents()
						spell.inputManager.clearCommands()
					}
			
					var ClearKeyInput = function( spell ) {}
			
					ClearKeyInput.prototype = {
						init : function( spell ) {},
						destroy : function( spell ) {},
						activate : function( spell ) {},
						deactivate : function( spell ) {},
						process : process
					}
			
					return ClearKeyInput
				}
			)
			
			/**
			 * @class spell.system.debug.camera
			 * @singleton
			 */
			
			define(
				'spell/system/debug/camera',
				[
					'spell/script/editor/cameraMover',
					'spell/script/editor/entityMover',
					'spell/script/editor/selectedEntityHighlighter',
					'spell/script/editor/entityRemover',
			
					'spell/script/editor/tilemapEditor',
			
					'spell/math/vec2',
					'spell/math/mat3',
			        'spell/shared/util/create',
					'spell/functions'
				],
				function(
					cameraMover,
					entityMover,
					selectedEntityHighlighter,
					entityRemover,
					tilemapEditor,
			
					vec2,
					mat3,
			
			        create,
					_
					) {
					'use strict'
			
					var PLUGIN_MANIFEST = {
					    'cameraMover':                  cameraMover,
				        'entityMover':                  entityMover,
				        'entityRemover':                entityRemover,
				        'selectedEntityHighlighter':    selectedEntityHighlighter,
				        'tilemapEditor':                tilemapEditor
					};
			
			
					/**
					 * Creates an instance of the system.
					 *
					 * @constructor
					 * @param {Object} [spell] The spell object.
					 */
					var interactiveEditingSystem = function( spell ) {
			
						/**
						 * Array holding a list of blacklisted plugins (plugins, that are not activated by default and can't be activated)
						 * @type {Array}
						 */
						this.blacklistedPlugins = []
			
						/**
						 * Array holding a list of all plugins that a currently active
						 * @type {Array}
						 */
						this.activePlugins = []
			
						/**
						 * Map holding pluginName => pluginInstance
						 * @type {Object}
						 */
						this.plugins = {}
			
						/**
						 * Reference to the spell object
						 */
						this.spell      = spell
			
						this.commandMode                = false
			
						/**
						 * The entityId of the currently selected entity
						 */
						this.selectedEntity             = null
			
						/**
						 * vec2 holding holding the current position of the pointer in world coordinates
						 * (null unless initialized
						 * @type {null}
						 */
						this.cursorWorldPosition        = null
			
					}
			
					//private
					var invokePlugins = function( plugins, pluginNames, functionName ) {
						var args = Array.prototype.slice.call(arguments, 3);
			
						for( var i = 0; i < pluginNames.length; i++ ) {
							var pluginName          = pluginNames[ i ],
								pluginInstance      = plugins[ pluginName ]
			
							if( !pluginInstance ) {
								continue
							}
			
							var	fn                  = pluginInstance.prototype[ functionName ]
			
							if ( fn ) {
								fn.apply( pluginInstance, args )
							}
						}
					}
			
					var processEvent = function ( spell, event ) {
			
						var KEY = spell.inputManager.KEY
			
						if(event.position) {
							this.cursorWorldPosition = spell.renderingContext.transformScreenToWorld( event.position )
						}
			
						if(event.type == 'keyDown' &&  event.keyCode == KEY.CTRL || event.keyCode == KEY.LEFT_WINDOW_KEY) {
							this.commandMode = true
			
						} else if(event.type == 'keyUp' &&  event.keyCode == KEY.CTRL || event.keyCode == KEY.LEFT_WINDOW_KEY) {
							this.commandMode = false
						}
			
						invokePlugins( this.plugins, this.activePlugins, event.type, spell, this, event )
					}
			
					var checkPermission = function( entityId, permission ) {
						var editorConfigurations = this.editorConfigurations,
							editorConfiguration  = editorConfigurations[ entityId ]
			
						if( editorConfiguration && editorConfiguration[ permission ] === false) {
							return false
						} else {
							return true
						}
					}
			
					//public
					interactiveEditingSystem.prototype = {
						setSelectedEntity: function( entityId ) {
							this.selectedEntity = entityId
			/*
							this.spell.sendMessageToEditor(
								'spelled.debug.entity.select',
								{
									id: entityId
								}
							)
			
			
			*/
						},
			
						isMoveable: function( entityId ) {
							return checkPermission.call( this, entityId, 'isMoveable' )
						},
			
						isCloneable: function ( entityId ) {
							return checkPermission.call( this, entityId, 'isCloneable' )
						},
			
						isSelectable: function( entityId ) {
							return checkPermission.call( this, entityId, 'isSelectable' )
						},
			
						isRemovable: function( entityId ) {
							return checkPermission.call( this, entityId, 'isRemovable' )
						},
			
						getSelectedEntity: function( entityId ) {
							return this.selectedEntity
						},
			
						activatePlugin: function(pluginName) {
							if( !this.plugins[ pluginName ] ) {
								//plugin is not available
								return
							}
			
							this.activePlugins.push(pluginName)
			
							invokePlugins( this.plugins, [pluginName], 'activate', this.spell, this)
						},
			
						activateAllPlugins: function() {
							this.activePlugins = _.keys(PLUGIN_MANIFEST)
			
							invokePlugins( this.plugins, this.activePlugins, 'activate', this.spell, this)
						},
			
						deactivatePlugin: function( pluginName ) {
							var plugins         = this.plugins,
								activePlugins   = this.activePlugins,
								spell           = this.spell,
								me              = this
			
							this.activePlugins = _.filter(
								activePlugins,
								function( pluginNameIter ) {
									if( pluginNameIter === pluginName ) {
										invokePlugins( plugins, [ pluginName ], 'deactivate', spell, me)
			
										return false
									}
			
									return true
								}
							)
						},
			
						deactivateAllPlugins: function() {
							invokePlugins( this.plugins, this.activePlugins, 'deactivate', this.spell, this)
							this.activePlugins = []
						},
			
						/**
						 * Gets called when the system is created.
						 *
						 * @param {Object} [spell] The spell object.
						 */
						init: function( spell ) {
						    this.blacklistedPlugins = this.config.deactivatedPlugins
			
							if (this.config.selectedEntityId) {
								this.selectedEntity     = this.config.selectedEntityId
							}
			
							this.activePlugins = []
							for (var pluginName in PLUGIN_MANIFEST) {
			
								if ( _.indexOf(this.blacklistedPlugins, pluginName) !== -1 ) {
									//if this plugin is blacklisted, ignore it completly
									continue
								}
			
								var pluginConstructor = PLUGIN_MANIFEST[ pluginName ],
									pluginInstance = create(pluginConstructor, [ spell, this ], { })
			
								this.plugins[ pluginName ] = pluginInstance
			
								this.activePlugins.push(pluginName)
							}
			
							invokePlugins( this.plugins, this.activePlugins, 'init', spell, this)
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
							this.prototype.activateAllPlugins.call( this )
						},
			
						/**
						 * Gets called when the system is deactivated.
						 *
						 * @param {Object} [spell] The spell object.
						 */
						deactivate: function( spell ) {
							this.prototype.deactivateAllPlugins.call( this )
						},
			
						/**
						 * Gets called to trigger the processing of game state.
						 *
						 * @param {Object} [spell] The spell object.
						 * @param {Object} [timeInMs] The current time in ms.
						 * @param {Object} [deltaTimeInMs] The elapsed time in ms.
						 */
						process: function( spell, timeInMs, deltaTimeInMs ) {
			
							//process event queue
							var inputEvents      = spell.inputManager.getInputEvents()
							for( var i = 0, numInputEvents = inputEvents.length; i < numInputEvents; i++ ) {
			
								processEvent.call( this, spell, inputEvents[ i ] )
			
							}
			
							invokePlugins( this.plugins, this.activePlugins, 'process', spell, this, timeInMs, deltaTimeInMs)
			
							//consume all input events if we're in commandMode
							if( this.commandMode == true ) {
								spell.inputManager.clearInputEvents()
							}
						}
					}
			
					return interactiveEditingSystem
				}
			)
			
			/**
			 * Emits the following events on events to EventHandlers
			 *
			 * animationStart
			 * The animationstart event occurs at the start of the animation.
			 *
			 * animationEnd
			 * The animationend event occurs when the animation finishes.
			 *
			 * animationiteration
			 * The animationiteration event occurs at the end of each iteration of an animation,
			 * except when an animationend event would fire at the same time.
			 * This means that this event does not occur for animations with an iteration count of one or less.
			 *
			 */
			define(
				'spell/system/keyFrameAnimation',
				[
					'spell/shared/Easing',
					'spell/math/util',
					'spell/math/vec2',
			
					'spell/functions'
				],
				function(
					Easing,
					mathUtil,
					vec2,
			
					_
				) {
					'use strict'
			
			
					var clamp        = mathUtil.clamp,
						isInInterval = mathUtil.isInInterval,
						modulo       = mathUtil.modulo
			
					var getKeyFrameIdA = function( keyFrames, offset ) {
						for( var i = 0, numKeyFrames = keyFrames.length; i < numKeyFrames; i++ ) {
							if( keyFrames[ i ].time > offset ) {
								return i - 1
							}
						}
					}
			
					var getEasingFunction = function( name ) {
						if( !name ) name = 'Linear'
			
						var fn = Easing[ name ]
			
						if( !fn ) {
							throw 'Error: Unkown easing function \'' + name + '\'.'
						}
			
						return fn
					}
			
					var createOffset = function( deltaTimeInMs, animationLengthInMs, offsetInMs, replaySpeed, reversed ) {
						return Math.round( offsetInMs + deltaTimeInMs * replaySpeed * ( reversed ? -1 : 1 ) )
					}
			
					var normalizeOffset = function( animationLengthInMs, offsetInMs, looped ) {
						return looped ?
							modulo( offsetInMs, animationLengthInMs ) :
							clamp( offsetInMs, 0, animationLengthInMs )
					}
			
					var updatePlaying = function( animationLengthInMs, offsetInMs, looped ) {
						return looped ?
							true :
							isInInterval( offsetInMs, 0, animationLengthInMs )
					}
			
					var lerp = function( a, b, t ) {
						return a + ( b - a ) * t
					}
			
					var process = function( spell, timeInMs, deltaTimeInMs ) {
						var entityManager      = this.entityManager,
							keyFrameAnimations = this.keyFrameAnimations,
							worldPassEntities  = spell.worldPassEntities,
							uiPassEntities  = spell.uiPassEntities
			
						for( var id in keyFrameAnimations ) {
							var keyFrameAnimation = keyFrameAnimations[ id ]
			
							if( !keyFrameAnimation.playing ) continue
			
							var keyFrameAnimationAsset = keyFrameAnimation.asset,
								animate                = keyFrameAnimationAsset.animate,
								lengthInMs             = keyFrameAnimationAsset.length
			
							var rawOffset = createOffset(
								deltaTimeInMs,
								lengthInMs,
								keyFrameAnimation.offset,
								keyFrameAnimation.replaySpeed,
								keyFrameAnimation.reversed
							)
			
							var offset = normalizeOffset( lengthInMs, rawOffset, keyFrameAnimation.looped )
			
							keyFrameAnimation.offset  = offset
							keyFrameAnimation.playing = updatePlaying( lengthInMs, rawOffset, keyFrameAnimation.looped )
			
							if( !worldPassEntities[ id ] && !uiPassEntities[ id ] ) {
								// HACK: If an entity is not visible do not bother updating its components. This will inevitable lead
								// to visual artifacts when the bound of the entity is smaller than the space covered by the key
								// frame animation. As the time of this writing this is not the case. The real solution is to
								// compute the bounds of entities properly.
								continue
							}
			
							for( var componentId in animate ) {
								var componentAnimation = animate[ componentId ],
									component          = entityManager.getComponentById( id, componentId )
			
								if( !component ) {
									throw 'Error: Unable to access component \'' + componentId + '\' of entity \'' + id + '\'.'
								}
			
								for( var attributeId in componentAnimation ) {
									var attributeAnimation = componentAnimation[ attributeId ],
										keyFrames          = attributeAnimation.keyFrames,
										keyFrameIdA        = getKeyFrameIdA( keyFrames, offset )
			
									if( keyFrameIdA < 0 ) {
										// set to first key frame value
										entityManager.updateComponentAttribute( id, componentId, attributeId, keyFrames[ 0 ].value )
			
										continue
									}
			
									if( keyFrameIdA === undefined ) {
										// set to last key frame value
										entityManager.updateComponentAttribute( id, componentId, attributeId, keyFrames[ keyFrames.length - 1 ].value )
			
										continue
									}
			
									var keyFrameIdB = keyFrameIdA + 1,
										keyFrameA   = keyFrames[ keyFrameIdA ],
										keyFrameB   = keyFrames[ keyFrameIdB ]
			
									// interpolate between key frame A and B
									var attributeOffset = offset - keyFrameA.time,
										easingFunction  = getEasingFunction( keyFrameB.interpolation ),
										t               = easingFunction( attributeOffset / ( keyFrameB.time - keyFrameA.time ) )
			
									if( _.isArray( component[ attributeId ] ) ) {
										entityManager.updateComponentAttribute(
											id,
											componentId,
											attributeId,
											vec2.lerp( component[ attributeId ], keyFrameA.value, keyFrameB.value, t )
										)
			
									} else {
										entityManager.updateComponentAttribute(
											id,
											componentId,
											attributeId,
											lerp( keyFrameA.value, keyFrameB.value, t )
										)
									}
								}
							}
			
							if( keyFrameAnimation.playing === false ) {
								entityManager.triggerEvent( id, 'animationEnd', [ 'keyFrameAnimation', keyFrameAnimation ] )
							}
						}
					}
			
					var KeyFrameAnimation = function( spell ) {
						this.entityManager = spell.entityManager
					}
			
					KeyFrameAnimation.prototype = {
						init : function() {},
						destroy : function() {},
						activate : function() {},
						deactivate : function() {},
						process : process
					}
			
					return KeyFrameAnimation
				}
			)
			
			/**
			 * @class parallax
			 * @singleton
			 */
			
			define(
				'spell/system/parallax',
				[
					'spell/Defines',
					'spell/Events',
					'spell/math/vec2'
				],
				function(
					Defines,
					Events,
					vec2
				) {
					'use strict'
			
			
					var entityLookupMap = {}
			
					var lookupEntityId = function( entityManager, entityName ) {
						var entityId = entityLookupMap[ entityName ]
			
						if( entityId ) {
							return entityId
						}
			
						entityId = entityManager.getEntityIdsByName( entityName )[ 0 ]
			
						if( !entityId ) {
							throw 'Could not find entity with the name ' + entityName
						}
			
						entityLookupMap[ entityName ] = entityId
			
						return entityId
					}
			
			
					/**
					 * Creates an instance of the system.
					 *
					 * @constructor
					 * @param {Object} [spell] The spell object.
					 */
					var parallax = function( spell ) {}
			
					parallax.prototype = {
						/**
						 * Gets called when the system is created.
						 *
						 * @param {Object} [spell] The spell object.
						 */
						init: function( spell ) {
							entityLookupMap = {}
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
							var entityManager        = spell.entityManager,
								parallaxComponents   = this.parallaxComponents,
								quads                = this.quads,
								transforms           = this.transforms,
								textureMatrices      = this.textureMatrices
			
							for( var entityId in parallaxComponents ) {
								var parallax              = parallaxComponents[ entityId ],
									layerQuad             = quads[ entityId ],
									layerTransform        = transforms[ entityId ],
									refEntityTranslation  = transforms[ lookupEntityId( entityManager, parallax.refEntityName ) ].translation,
									appearanceTranslation = textureMatrices[ entityId ].translation
			
								if( !layerTransform || !refEntityTranslation || !layerQuad ) {
									throw 'could not get a valid parallax configuration for entity id ' + entityId
								}
			
								// set the texture coordinates to the new position, according to speed, camera position and texture offset
								vec2.multiply( appearanceTranslation, refEntityTranslation, parallax.moveSpeed )
								vec2.divide( appearanceTranslation, appearanceTranslation, layerQuad.dimensions )
								vec2.add( appearanceTranslation, appearanceTranslation, parallax.textureOffset )
			
								// clamp x, y values if we don't want to repeat the texture
								if( !parallax.repeatX ) {
									if( appearanceTranslation[ 0 ] < 0 ) {
										appearanceTranslation[ 0 ] = 0
									}
			
									if( appearanceTranslation[ 0 ] > 1 ) {
										appearanceTranslation[ 0 ] = 1
									}
								}
			
								if( !parallax.repeatY ) {
									if( appearanceTranslation[ 1 ] < 0 ) {
										appearanceTranslation[ 1 ] = 0
									}
			
									if( appearanceTranslation[ 1 ] > 1 ) {
										appearanceTranslation[ 1 ] = 1
									}
								}
			
								entityManager.updateTextureMatrix( entityId )
							}
						}
					}
			
					return parallax
				}
			)
			
			define(
				'spell/system/physics',
				[
					'spell/Defines',
					'spell/Events',
					'spell/math/util',
					'spell/shared/util/platform/PlatformKit',
			
					'spell/functions'
				],
				function(
					Defines,
					Events,
					mathUtil,
					PlatformKit,
			
					_
				) {
					'use strict'
			
			
					var Box2D                   = PlatformKit.Box2D,
						b2_staticBody           = Box2D.Dynamics.b2Body.b2_staticBody,
						createB2Vec2            = Box2D.Common.Math.createB2Vec2,
						createB2FixtureDef      = Box2D.Dynamics.createB2FixtureDef,
						createB2ContactListener = Box2D.Dynamics.createB2ContactListener,
						createB2PolygonShape    = Box2D.Collision.Shapes.createB2PolygonShape,
						createB2CircleShape     = Box2D.Collision.Shapes.createB2CircleShape
			
					var awakeColor    = [ 0.82, 0.76, 0.07 ],
						notAwakeColor = [ 0.27, 0.25, 0.02 ]
			
					var entityEventBeginContact = function( entityManager, contactTriggers, eventId, contact, manifold ) {
						var entityIdA = contact.GetFixtureA().GetUserData(),
							entityIdB = contact.GetFixtureB().GetUserData(),
							contactTrigger
			
						if( entityIdA ) {
							entityManager.triggerEvent( entityIdA, eventId, [ entityIdB, contact, manifold ] )
			
							contactTrigger = contactTriggers[ entityIdA ]
			
							if( contactTrigger && entityIdB ) {
								entityManager.triggerEvent( entityIdB, contactTrigger.eventId, [ entityIdA ].concat( contactTrigger.parameters ) )
							}
						}
			
						if( entityIdB ) {
							entityManager.triggerEvent( entityIdB, eventId, [ entityIdA, contact, manifold ] )
			
							contactTrigger = contactTriggers[ entityIdB ]
			
							if( contactTrigger && entityIdA ) {
								entityManager.triggerEvent( entityIdA, contactTrigger.eventId, [ entityIdB ].concat( contactTrigger.parameters ) )
							}
						}
					}
			
					var entityEventEndContact = function( entityManager, eventId, contact, manifold ) {
						var entityIdA = contact.GetFixtureA().GetUserData(),
							entityIdB = contact.GetFixtureB().GetUserData()
						if( entityIdA ) {
							entityManager.triggerEvent( entityIdA, eventId, [ entityIdB, contact, manifold ] )
						}
			
						if( entityIdB ) {
							entityManager.triggerEvent( entityIdB, eventId, [ entityIdA, contact, manifold ] )
						}
					}
			
					var createContactListener = function( entityManager, contactTriggers ) {
						return createB2ContactListener(
							function( contact, manifold ) {
								entityEventBeginContact( entityManager, contactTriggers, 'beginContact', contact, manifold )
							},
							function( contact, manifold ) {
								entityEventEndContact( entityManager, 'endContact', contact, manifold )
							},
							null,
							null
						)
					}
			
					var createBody = function( spell, debug, world, entityId, entity ) {
						var body               = entity[ Defines.PHYSICS_BODY_COMPONENT_ID ],
							fixture            = entity[ Defines.PHYSICS_FIXTURE_COMPONENT_ID ],
							boxShape           = entity[ Defines.PHYSICS_BOX_SHAPE_COMPONENT_ID ],
							circleShape        = entity[ Defines.PHYSICS_CIRCLE_SHAPE_COMPONENT_ID ],
							convexPolygonShape = entity[ Defines.PHYSICS_CONVEX_POLYGON_SHAPE_COMPONENT_ID ],
							transform          = entity[ Defines.TRANSFORM_COMPONENT_ID ]
			
						if( !body || !fixture || !transform ||
							( !boxShape && !circleShape && !convexPolygonShape ) ) {
			
							return
						}
			
						createPhysicsObject( world, entityId, body, fixture, boxShape, circleShape, convexPolygonShape, transform )
			
						if( debug ) {
							var componentId,
								config
			
							if( circleShape ) {
								componentId = 'spell.component.2d.graphics.debug.circle'
								config = {
									radius : circleShape.radius
								}
			
							} else if( convexPolygonShape ) {
								var minX = _.reduce( convexPolygonShape.vertices, function( memo, v ) { var x = v[ 0 ]; return memo < x ? memo : x }, 0 ),
									maxX = _.reduce( convexPolygonShape.vertices, function( memo, v ) { var x = v[ 0 ]; return memo > x ? memo : x }, 0 ),
									minY = _.reduce( convexPolygonShape.vertices, function( memo, v ) { var y = v[ 1 ]; return memo < y ? memo : y }, 0 ),
									maxY = _.reduce( convexPolygonShape.vertices, function( memo, v ) { var y = v[ 1 ]; return memo > y ? memo : y }, 0 )
			
								componentId = 'spell.component.2d.graphics.debug.box'
								config = {
									width : maxX - minX,
									height : maxY - minY
								}
			
							} else {
								var boxesqueShape = boxShape
			
								componentId = 'spell.component.2d.graphics.debug.box'
								config = {
									width : boxesqueShape.dimensions[ 0 ],
									height : boxesqueShape.dimensions[ 1 ]
								}
							}
			
							spell.entityManager.addComponent(
								entityId,
								componentId,
								config
							)
						}
					}
			
					var destroyBodies = function( world, entityIds ) {
						for( var i = 0, numEntityIds = entityIds.length; i < numEntityIds; i++ ) {
							world.destroyBody( entityIds[ i ] )
						}
					}
			
					var addShape = function( world, worldToPhysicsScale, entityId, bodyDef, fixture, boxShape, circleShape, convexPolygonShape ) {
						var fixtureDef = createB2FixtureDef()
			
						fixtureDef.density     = fixture.density
						fixtureDef.friction    = fixture.friction
						fixtureDef.restitution = fixture.restitution
						fixtureDef.isSensor    = fixture.isSensor
						fixtureDef.userData    = entityId
			
						fixtureDef.filter.categoryBits = fixture.categoryBits
						fixtureDef.filter.maskBits     = fixture.maskBits
			
						if( boxShape ) {
							fixtureDef.shape = createB2PolygonShape()
							fixtureDef.shape.SetAsBox(
								boxShape.dimensions[ 0 ] / 2 * worldToPhysicsScale,
								boxShape.dimensions[ 1 ] / 2 * worldToPhysicsScale
							)
			
							bodyDef.CreateFixture( fixtureDef )
			
						} else if( circleShape ) {
							fixtureDef.shape = createB2CircleShape( circleShape.radius * worldToPhysicsScale )
			
							bodyDef.CreateFixture( fixtureDef )
			
						} else if( convexPolygonShape ) {
							var vertices = convexPolygonShape.vertices
			
							fixtureDef.shape = createB2PolygonShape()
							fixtureDef.shape.SetAsArray(
								_.map(
									vertices,
									function( x ) { return createB2Vec2( x[ 0 ] * worldToPhysicsScale, x[ 1 ] * worldToPhysicsScale ) }
								),
								vertices.length
							)
			
							bodyDef.CreateFixture( fixtureDef )
						}
					}
			
					var createPhysicsObject = function( world, entityId, body, fixture, boxShape, circleShape, convexPolygonShape, transform ) {
						var bodyDef = world.createBodyDef( entityId, body, transform )
			
						if( !bodyDef ) return
			
						addShape( world, world.scale, entityId, bodyDef, fixture, boxShape, circleShape, convexPolygonShape )
					}
			
					var step = function( rawWorld, deltaTimeInMs ) {
						rawWorld.Step( deltaTimeInMs / 1000, 10, 8 )
						rawWorld.ClearForces()
					}
			
					var incrementState = function( entityManager, world, invWorldToPhysicsScale, bodies, transforms ) {
						for( var body = world.GetBodyList(); body; body = body.GetNext() ) {
							if( body.GetType() == b2_staticBody ||
								!body.IsAwake() ) {
			
								continue
							}
			
							var id = body.GetUserData()
							if( !id ) continue
			
							// transfering state to components
							var position  = body.GetPosition(),
								transform = transforms[ id ]
			
							if( !transform ) continue
			
							transform.translation[ 0 ] = position.x * invWorldToPhysicsScale
							transform.translation[ 1 ] = position.y * invWorldToPhysicsScale
							transform.rotation = body.GetAngle() * 1
			
							entityManager.updateWorldTransform( id )
			
							// updating velocity
							var velocity = body.GetLinearVelocity(),
								bodyComponent = bodies[ id ],
								maxVelocity   = bodyComponent.maxVelocity
			
							if( maxVelocity ) {
								// clamping velocity to range
								var maxVelocityX = maxVelocity[ 0 ],
									maxVelocityY = maxVelocity[ 1 ]
			
								velocity.x = mathUtil.clamp( velocity.x, -maxVelocityX, maxVelocityX )
								velocity.y = mathUtil.clamp( velocity.y, -maxVelocityY, maxVelocityY )
			
								body.SetLinearVelocity( velocity )
							}
			
							bodyComponent.velocity[ 0 ] = velocity.x * invWorldToPhysicsScale
							bodyComponent.velocity[ 1 ] = velocity.y * invWorldToPhysicsScale
						}
					}
			
					var updateDebug = function( world, debugBoxes, debugCircles ) {
						for( var body = world.GetBodyList(); body; body = body.GetNext() ) {
							var id = body.GetUserData()
			
							if( !id ) continue
			
							var debugShape = debugBoxes[ id ] || debugCircles[ id ]
			
							debugShape.color = body.IsAwake() ? awakeColor : notAwakeColor
						}
					}
			
					var init = function( spell ) {
						this.world = spell.box2dWorlds.main
			
						if( !this.world ) {
							var doSleep = true,
								world   = spell.box2dContext.createWorld( doSleep, this.config.gravity, this.config.scale )
			
							world.getRawWorld().SetContactListener(
								createContactListener( spell.entityManager, this.contactTriggers )
							)
			
							this.world = world
							spell.box2dWorlds.main = world
						}
			
						this.entityCreatedHandler = _.bind( createBody, null, spell, this.config.debug, this.world )
						this.entityDestroyHandler = _.bind( this.removedEntitiesQueue.push, this.removedEntitiesQueue )
			
						spell.eventManager.subscribe( Events.ENTITY_CREATED, this.entityCreatedHandler )
						spell.eventManager.subscribe( Events.ENTITY_DESTROYED, this.entityDestroyHandler )
					}
			
					var destroy = function( spell ) {
						spell.eventManager.unsubscribe( Events.ENTITY_CREATED, this.entityCreatedHandler )
						spell.eventManager.unsubscribe( Events.ENTITY_DESTROYED, this.entityDestroyHandler )
					}
			
					var process = function( spell, timeInMs, deltaTimeInMs ) {
						var world                = this.world,
							rawWorld             = this.world.getRawWorld(),
							transforms           = this.transforms,
							removedEntitiesQueue = this.removedEntitiesQueue
			
						if( removedEntitiesQueue.length ) {
							destroyBodies( world, removedEntitiesQueue )
							removedEntitiesQueue.length = 0
						}
			
						step( rawWorld, deltaTimeInMs )
			
						incrementState( spell.entityManager, rawWorld, 1 / world.scale, this.bodies, transforms )
			
						if( this.config.debug ) {
							updateDebug( rawWorld, this.debugBoxes, this.debugCircles )
						}
					}
			
					var Physics = function( spell ) {
						this.entityCreatedHandler
						this.entityDestroyHandler
						this.world
						this.removedEntitiesQueue = []
					}
			
					Physics.prototype = {
						init : init,
						destroy : destroy,
						activate : function( spell ) {},
						deactivate : function( spell ) {},
						process : process
					}
			
					return Physics
				}
			)
			
			define(
				'spell/system/processInputCommands',
				[
					'spell/Defines',
					'spell/Events',
			
					'spell/functions'
				],
				function(
					Defines,
					Events,
			
					_
				) {
					'use strict'
			
			
					/**
					 * Forward commands to entities.
					 *
					 * @param spell
					 * @param timeInMs
					 * @param deltaTimeInMs
					 */
					var process = function( spell, timeInMs, deltaTimeInMs ) {
						var commands            = spell.inputManager.getCommands(),
							entityManager       = spell.entityManager,
							playerControlledIds = this.playerControlledIds
			
						for( var i = 0, n = commands.length; i < n; i++ ) {
							for( var j = 0, m = playerControlledIds.length; j < m; j++ ) {
								entityManager.triggerEvent( playerControlledIds[ j ], commands[ i ] )
							}
						}
					}
			
					var processInputCommands = function( spell ) {}
			
					processInputCommands.prototype = {
						init : function( spell ) {
							spell.inputManager.clearCommands()
			
							var playerControlledIds = this.playerControlledIds = []
			
							var processControllableComponentEvents = this.processControllableComponentEvents = function( component, entityId ) {
								if( component.controllerId !== 'player' ||
									_.contains( playerControlledIds, entityId ) ) {
			
									return
								}
			
								playerControlledIds.push( entityId )
							}
			
							spell.eventManager.subscribe( [ Events.COMPONENT_CREATED, Defines.CONTROLLABLE_COMPONENT_ID ], processControllableComponentEvents )
							spell.eventManager.subscribe( [ Events.COMPONENT_UPDATED, Defines.CONTROLLABLE_COMPONENT_ID ], processControllableComponentEvents )
						},
						destroy : function( spell ) {
							var processControllableComponentEvents = this.processControllableComponentEvents
			
							spell.eventManager.unsubscribe( [ Events.COMPONENT_CREATED, Defines.CONTROLLABLE_COMPONENT_ID ], processControllableComponentEvents )
							spell.eventManager.unsubscribe( [ Events.COMPONENT_UPDATED, Defines.CONTROLLABLE_COMPONENT_ID ], processControllableComponentEvents )
						},
						activate : function( spell ) {},
						deactivate : function( spell ) {},
						process : process
					}
			
					return processInputCommands
				}
			)
			
			define(
				'spell/system/processPointerInput',
				[
					'spell/Defines',
					'spell/Events',
					'spell/client/util/createEffectiveCameraDimensions',
					'spell/math/util',
					'spell/math/vec2',
			
					'spell/functions'
				],
				function(
					Defines,
					Events,
					createEffectiveCameraDimensions,
					mathUtil,
					vec2,
			
					_
				) {
					'use strict'
			
			
					var currentCameraId
			
					var isPointWithinEntity = function ( entityDimensions, transform, worldPosition ) {
						return mathUtil.isPointInRect(
							worldPosition,
							transform.worldTranslation,
							entityDimensions[ 0 ],
							entityDimensions[ 1 ],
							transform.rotation // TODO: should be worldRotation
						)
					}
			
					var transformScreenToUI = function( screenSize, effectiveCameraDimensions, cursorPosition ) {
						return [
							( cursorPosition[ 0 ] / screenSize[ 0 ] - 0.5 ) * effectiveCameraDimensions[ 0 ],
							( cursorPosition[ 1 ] / screenSize[ 1 ] - 0.5 ) * -effectiveCameraDimensions[ 1 ]
						]
					}
			
					var processEvent = function( entityManager, screenSize, effectiveCameraDimensions, pointedEntityMap, renderingContext, eventHandlers, transforms, visualObjects, inputEvent ) {
						if( inputEvent.type !== 'pointerDown' &&
							inputEvent.type !== 'pointerMove' &&
							inputEvent.type !== 'pointerUp' &&
							inputEvent.type !== 'pointerCancel' ) {
			
							return
						}
			
						var cursorScreenPosition = inputEvent.position,
			            	cursorWorldPosition  = renderingContext.transformScreenToWorld( cursorScreenPosition ),
							cursorUIPosition     = transformScreenToUI( screenSize, effectiveCameraDimensions, cursorScreenPosition )
			
			            // TODO: only check visible objects
			            for( var entityId in eventHandlers ) {
			                var transform    = transforms[ entityId ],
								visualObject = visualObjects[ entityId ]
			
			                if( !transform ||
								!visualObject ) {
			
			                    continue
			                }
			
							var isInUIPass = visualObject.pass === 'ui'
			
							if( pointedEntityMap[ entityId ] === undefined ) {
								pointedEntityMap[ entityId ] = false
							}
			
			                if( inputEvent.type === 'pointerCancel' &&
								pointedEntityMap[ entityId ] === inputEvent.pointerId ) {
			
			                    entityManager.triggerEvent( entityId, 'pointerCancel' )
			                    entityManager.triggerEvent( entityId, 'pointerUp' )
			                    entityManager.triggerEvent( entityId, 'pointerOut' )
			                    pointedEntityMap[ entityId ] = false
			
			                    continue
			                }
			
							var entityDimensions = entityManager.getEntityDimensions( entityId )
			
							var isEntityHit = isPointWithinEntity(
								entityDimensions,
								transform,
								isInUIPass ? cursorUIPosition : cursorWorldPosition
							)
			
							if( entityDimensions &&
								isEntityHit ) {
			
			                    if( pointedEntityMap[ entityId ] === false ) {
			                        entityManager.triggerEvent( entityId, 'pointerOver' )
			                    }
			
			                    if( inputEvent.type === 'pointerUp' ) {
			                        pointedEntityMap[ entityId ] = false
			                        entityManager.triggerEvent( entityId, 'pointerUp' )
			
			                        // TODO: only fire pointerOut for devices that don't support hover status
			                        entityManager.triggerEvent( entityId, 'pointerOut' )
			
			
			                    } else if( inputEvent.type === 'pointerDown' ) {
			                        pointedEntityMap[ entityId ] = inputEvent.pointerId
			                        entityManager.triggerEvent( entityId, 'pointerDown' )
			
								} else if( inputEvent.type === 'pointerMove' ) {
			                        pointedEntityMap[ entityId ] = inputEvent.pointerId
			                        entityManager.triggerEvent( entityId, 'pointerMove' )
								}
			
							} else if( pointedEntityMap[ entityId ] === inputEvent.pointerId ) {
								// pointer moved out of the entity
								pointedEntityMap[ entityId ] = false
								entityManager.triggerEvent( entityId, 'pointerOut' )
							}
						}
					}
			
			
					/**
					 * Creates an instance of the system.
					 *
					 * @constructor
					 * @param {Object} [spell] The spell object.
					 */
					var processPointerInput = function( spell ) {
						this.screenSize           = spell.configurationManager.getValue( 'currentScreenSize' )
						this.screenResizeHandler
						this.cameraChangedHandler
					}
			
					processPointerInput.prototype = {
						/**
					 	 * Gets called when the system is created.
					 	 *
					 	 * @param {Object} [spell] The spell object.
						 */
						init: function( spell ) {
							/**
							 * Holds a map entityId => Boolean whether an entity is currently pointed to or not
							 * @type {Object}
							 */
							this.pointedEntityMap = {}
			
			
							var eventManager = spell.eventManager
			
							this.cameraChangedHandler = _.bind(
								function( camera, entityId ) {
									currentCameraId = camera.active ? entityId : undefined
								},
								this
							)
			
							eventManager.subscribe( [ Events.COMPONENT_CREATED, Defines.CAMERA_COMPONENT_ID ], this.cameraChangedHandler )
							eventManager.subscribe( [ Events.COMPONENT_UPDATED, Defines.CAMERA_COMPONENT_ID ], this.cameraChangedHandler )
			
			
							this.screenResizeHandler = _.bind(
								function( size ) {
									this.screenSize = size
								},
								this
							)
			
							eventManager.subscribe( Events.SCREEN_RESIZE, this.screenResizeHandler )
						},
			
						/**
					 	 * Gets called when the system is destroyed.
					 	 *
					 	 * @param {Object} [spell] The spell object.
						 */
						destroy: function( spell ) {
							var eventManager = spell.eventManager
			
							eventManager.unsubscribe( [ Events.COMPONENT_CREATED, Defines.CAMERA_COMPONENT_ID ], this.cameraChangedHandler )
							eventManager.unsubscribe( [ Events.COMPONENT_UPDATED, Defines.CAMERA_COMPONENT_ID ], this.cameraChangedHandler )
							eventManager.unsubscribe( Events.SCREEN_RESIZE, this.screenResizeHandler )
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
							var entityManager    = spell.entityManager,
								inputEvents      = spell.inputManager.getInputEvents(),
								pointedEntityMap = this.pointedEntityMap,
								renderingContext = spell.renderingContext,
								transforms       = this.transforms,
			                    eventHandlers    = this.eventHandlers,
								visualObjects    = this.visualObjects,
								camera           = this.cameras[ currentCameraId ],
								cameraTransform  = this.transforms[ currentCameraId ],
								screenSize       = this.screenSize
			
							var aspectRatio               = screenSize[ 0 ] / screenSize[ 1 ],
								effectiveCameraDimensions = createEffectiveCameraDimensions( camera.width, camera.height, cameraTransform.scale, aspectRatio )
			
							for( var i = 0, numInputEvents = inputEvents.length; i < numInputEvents; i++ ) {
								processEvent( entityManager, screenSize, effectiveCameraDimensions, pointedEntityMap, renderingContext, eventHandlers, transforms, visualObjects, inputEvents[ i ] )
							}
						}
					}
			
					return processPointerInput
				}
			)
			
			define(
				'spell/system/render',
				[
					'spell/client/2d/graphics/drawCoordinateGrid',
					'spell/client/2d/graphics/physics/drawBox',
					'spell/client/2d/graphics/physics/drawCircle',
					'spell/client/2d/graphics/physics/drawPoint',
					'spell/client/2d/graphics/physics/drawOrigin',
					'spell/client/2d/graphics/drawShape',
					'spell/client/2d/graphics/drawText',
					'spell/client/2d/graphics/drawTitleSafeOutline',
					'spell/client/util/createEffectiveCameraDimensions',
					'spell/client/util/createIncludedRectangle',
					'spell/Defines',
					'spell/Events',
					'spell/shared/util/translate',
					'spell/shared/util/platform/PlatformKit',
			
					'spell/math/util',
					'spell/math/vec2',
					'spell/math/vec4',
					'spell/math/mat3',
			
					'spell/functions'
				],
				function(
					drawCoordinateGrid,
					drawPhysicsBox,
					drawPhysicsCircle,
					drawPhysicsPoint,
					drawPhysicsOrigin,
					drawShape,
					drawText,
					drawTitleSafeOutline,
					createEffectiveCameraDimensions,
					createIncludedRectangle,
					Defines,
					Events,
					translate,
					PlatformKit,
			
					mathUtil,
					vec2,
					vec4,
					mat3,
			
					_
				) {
					'use strict'
			
			
					var tmpVec2           = vec2.create(),
						tmpVec2_1         = vec2.create(),
						tmpMat3           = mat3.identity( mat3.create() ),
						clearColor        = vec4.fromValues( 0, 0, 0, 1 ),
						markerColor       = vec4.fromValues( 0.45, 0.45, 0.45, 1.0 ),
						debugFontAssetId  = 'font:spell.OpenSans14px',
						drawDebugShapes   = true,
						defaultDimensions = vec2.fromValues( 1.0, 1.0 ),
						tmpViewFrustum    = { bottomLeft : vec2.create(), topRight : vec2.create() },
						currentCameraId
			
			//		var statisticsManager,
			//			performance = window.performance
			
					var translateTextAppearance = function( libraryManager, currentLanguage, textAppearance ) {
						var text = translate( libraryManager, currentLanguage, textAppearance.translationAssetId, textAppearance.text )
						if( !text ) return
			
						textAppearance.renderText = text
					}
			
					var layerCompareFunction = function( a, b ) {
						return a.layer - b.layer
					}
			
					/**
					 * Returns an array of root entity ids. "root" in this context means an entity which has a parent which is not in the set of entities.
					 *
					 * @param entities
					 * @return {Array}
					 */
					var getRootEntities = function( entities ) {
						var result = []
			
						for( var id in entities ) {
							if( !entities[ entities[ id ].parent ] ) {
								result.push( id )
							}
						}
			
						return result
					}
			
					var createVisualObjectsInDrawOrder = function( visibleEntities, entityIds ) {
						var result = []
			
						for( var i = 0, id, visibleEntity, n = entityIds.length; i < n; i++ ) {
							id = entityIds[ i ]
							visibleEntity = visibleEntities[ id ]
			
							if( !visibleEntity ) continue
			
							result.push( visibleEntity )
						}
			
						result.sort( layerCompareFunction )
			
						return result
					}
			
					var createEntityIdsInDrawOrder = function( visibleEntities, entityIds, result ) {
						var childrenIds,
							id,
							visibleEntity,
							visibleEntitiesSorted = createVisualObjectsInDrawOrder( visibleEntities, entityIds )
			
						for( var i = 0, n = visibleEntitiesSorted.length; i < n; i++ ) {
							visibleEntity = visibleEntitiesSorted[ i ]
							id = visibleEntity.id
			
							result.push( id )
			
							childrenIds = visibleEntity.children
			
							if( childrenIds && childrenIds.length > 0 ) {
								createEntityIdsInDrawOrder( visibleEntities, childrenIds, result )
							}
						}
					}
			
					var createVisibleEntityIdsSorted = function( entities ) {
						var result = []
			
						createEntityIdsInDrawOrder(
							entities,
							getRootEntities( entities ),
							result
						)
			
						return result
					}
			
					var createOffset = function( deltaTimeInMs, offset, replaySpeed, numFrames, frameDuration, loop ) {
						var animationLengthInMs = numFrames * frameDuration,
							offsetInMs          = Math.floor( animationLengthInMs * offset ) + deltaTimeInMs * replaySpeed
			
						if( offsetInMs > animationLengthInMs ) {
							if( !loop ) return 1
			
							offsetInMs %= animationLengthInMs
						}
			
						return animationLengthInMs === 0 ?
							0 :
							offsetInMs / animationLengthInMs
					}
			
					var updatePlaying = function( animationLengthInMs, offsetInMs, looped ) {
						return looped ?
							true :
							offsetInMs < animationLengthInMs
					}
			
					var transformTo2dTileMapCoordinates = function( worldToLocalMatrix, tilemapDimensions, frameDimensions, maxTileMapY, point ) {
						var transformedPoint = vec2.divide(
							tmpVec2,
							vec2.transformMat3(
								tmpVec2,
								point,
								worldToLocalMatrix
							),
							frameDimensions
						)
			
						vec2.add(
							transformedPoint,
							vec2.scale( tmpVec2_1, tilemapDimensions, 0.5 ),
							transformedPoint
						)
			
						transformedPoint[ 1 ] = maxTileMapY - transformedPoint[ 1 ]
			
						return transformedPoint
					}
			
					var draw2dTileMap = function( context, texture, viewFrustum, asset, transform, worldToLocalMatrix ) {
						var tilemapData = asset.tilemapData
			
						if( !tilemapData ) return
			
						var assetSpriteSheet  = asset.spriteSheet,
							tilemapDimensions = asset.tilemapDimensions,
							frameOffsets      = assetSpriteSheet.frameOffsets,
							frameDimensions   = assetSpriteSheet.frameDimensions,
							maxTileMapX       = tilemapDimensions[ 0 ] - 1,
							maxTileMapY       = tilemapDimensions[ 1 ] - 1
			
						// transform the view frustum to tile map coordinates, clamp to effective range
						var lowerLeft = transformTo2dTileMapCoordinates(
			                worldToLocalMatrix,
							tilemapDimensions,
							frameDimensions,
							maxTileMapY,
							viewFrustum.bottomLeft
						)
			
						var minTileMapSectionX = Math.max( Math.floor( lowerLeft[ 0 ] ), 0 ),
							maxTileMapSectionY = Math.min( Math.ceil( lowerLeft[ 1 ] ), maxTileMapY )
			
						var topRight = transformTo2dTileMapCoordinates(
			                worldToLocalMatrix,
							tilemapDimensions,
							frameDimensions,
							maxTileMapY,
							viewFrustum.topRight
						)
			
						var minTileSectionMapY = Math.max( Math.floor( topRight[ 1 ] ), 0 ),
							maxTileSectionMapX = Math.min( Math.ceil( topRight[ 0 ] ), maxTileMapX )
			
						context.save()
						{
							context.scale( frameDimensions )
			
							for( var y = minTileSectionMapY; y <= maxTileMapSectionY; y++ ) {
								var tilemapRow = tilemapData[ y ]
								if( !tilemapRow ) continue
			
								for( var x = minTileMapSectionX; x <= maxTileSectionMapX; x++ ) {
									var frameId = tilemapRow[ x ]
									if( frameId === null ) continue
			
									tmpVec2[ 0 ] = x - maxTileMapX * 0.5 - 0.5
									tmpVec2[ 1 ] = ( maxTileMapY - y ) - maxTileMapY * 0.5 - 0.5
			
									context.drawSubTexture(
										texture,
										frameOffsets[ frameId ],
										frameDimensions,
										tmpVec2,
										defaultDimensions
									)
								}
							}
						}
						context.restore()
					}
			
			        var worldToLocalMatrixCache = {}
			
					var drawVisualObject = function(
						entityManager,
						context,
						transforms,
						appearances,
						textureMatrices,
						animatedAppearances,
						textAppearances,
						tilemaps,
						spriteSheetAppearances,
						childrenComponents,
						quadGeometries,
						visualObjects,
						rectangles,
						deltaTimeInMs,
						id,
						viewFrustum
					) {
						var tilemap      = tilemaps[ id ],
							appearance   = appearances[ id ] || animatedAppearances[ id ] || tilemap || textAppearances[ id ] || spriteSheetAppearances[ id ],
							transform    = transforms[ id ],
							visualObject = visualObjects[ id ],
							quadGeometry = quadGeometries[ id ]
			
						context.save()
						{
							if( transform ) {
								context.setTransform( transform.worldMatrix )
							}
			
							if( visualObject ) {
								var worldOpacity = visualObject.worldOpacity
			
								if( worldOpacity < 1.0 ) {
									context.setGlobalAlpha( worldOpacity )
								}
			
								if( appearance ) {
									var asset   = appearance.asset,
										texture = asset.resource
			
									if( !texture ) throw 'The resource id \'' + asset.resourceId + '\' could not be resolved.'
			
									if( asset.type === 'appearance' ) {
										var textureMatrix  = textureMatrices[ id ],
											quadDimensions = quadGeometry ?
												quadGeometry.dimensions :
												texture.dimensions
			
			//							var start = performance.now()
			
										// static appearance
										context.save()
										{
											context.drawTexture(
												texture,
												vec2.scale( tmpVec2, quadDimensions, -0.5 ),
												quadDimensions,
												textureMatrix && !textureMatrix.isIdentity ?
													textureMatrix.matrix :
													undefined
											)
										}
										context.restore()
			
			//							var elapsed = performance.now() - start
			
									} else if( asset.type === 'font' ) {
			//							var start = performance.now()
			
										// text appearance
										drawText(
											context,
											asset,
											texture,
											0.0,
											0.0,
											appearance.renderText || appearance.text,
											appearance.spacing,
											appearance.align
										)
			
			//							var elapsed = performance.now() - start
			
									} else if( asset.type === '2dTileMap' ) {
			//							var start = performance.now()
			
			                            if( !worldToLocalMatrixCache[ id ] ) {
			                                worldToLocalMatrixCache[ id ] = mat3.create()
			                                mat3.invert( worldToLocalMatrixCache[ id ], transform.worldMatrix )
			
			                            }
			
										draw2dTileMap( context, texture, viewFrustum, asset, transform, worldToLocalMatrixCache[ id ] )
			
			//							var elapsed = performance.now() - start
			
									} else if( asset.type === 'animation' ) {
										// animated appearance
										var assetFrameDimensions = asset.frameDimensions,
											assetNumFrames       = asset.numFrames,
											assetFrameDuration   = asset.frameDuration,
											animationLengthInMs  = assetNumFrames * assetFrameDuration
			
										var quadDimensions = quadGeometry ?
											quadGeometry.dimensions :
											assetFrameDimensions
			
										if( appearance.playing === true && appearance.offset == 0 ) {
											entityManager.triggerEvent( id, 'animationStart', [ 'animation', appearance ] )
										}
			
										appearance.offset = createOffset(
											deltaTimeInMs,
											appearance.offset,
											appearance.replaySpeed,
											assetNumFrames,
											asset.frameDuration,
											appearance.looped
										)
			
										var frameId     = Math.round( appearance.offset * ( assetNumFrames - 1 ) ),
											frameOffset = asset.frameOffsets[ frameId ]
			
			//							var start = performance.now()
			
										context.save()
										{
											context.drawSubTexture(
												texture,
												frameOffset,
												assetFrameDimensions,
												vec2.scale( tmpVec2, quadDimensions, -0.5 ),
												quadDimensions
											)
										}
										context.restore()
			
			//							var elapsed = performance.now() - start
			
										var isPlaying = updatePlaying( animationLengthInMs, appearance.offset * animationLengthInMs, appearance.looped )
			
										if( isPlaying !== appearance.playing ) {
											appearance.playing = isPlaying
			
											if( isPlaying === false ) {
												entityManager.triggerEvent( id, 'animationEnd', [ 'animation', appearance ] )
											}
										}
			
									} else if( asset.type === 'spriteSheet' ) {
										var frames            = appearance.drawAllFrames ? asset.frames : appearance.frames,
											frameDimensions   = asset.frameDimensions,
											frameOffsets      = asset.frameOffsets,
											frameOffset       = undefined,
											quadDimensions    = quadGeometry ? quadGeometry.dimensions :  [ ( frames.length -0 ) * frameDimensions[ 0 ], frameDimensions[ 1 ] ],
											numFramesInQuad   = [
												Math.floor( quadDimensions[ 0 ] / frameDimensions[ 0 ] ),
												Math.floor( quadDimensions[ 1 ] / frameDimensions[ 1 ] )
											],
											totalFramesInQuad = numFramesInQuad[ 0 ] * numFramesInQuad[ 1 ]
			
										if( totalFramesInQuad > 0 ) {
											// only draw spriteSheet if we have at least space to draw one tile
			
			//								var start = performance.now()
			
											context.save()
											{
												context.scale( frameDimensions )
			
												for(
													var x = 0, length = frames.length;
												     x < length &&
													 x < totalFramesInQuad;
												     x++
													) {
			
													frameId     = frames[ x ]
													frameOffset = frameOffsets[ frameId ]
			
													tmpVec2[ 0 ] = -( quadDimensions[ 0 ] / frameDimensions[ 0 ] ) * 0.5 + x % numFramesInQuad[ 0 ]
													tmpVec2[ 1 ] = -( quadDimensions[ 1 ] / frameDimensions[ 1 ] ) * 0.5 + Math.floor( x / numFramesInQuad[ 0 ] )
			
													context.drawSubTexture(
														texture,
														frameOffset,
														frameDimensions,
														tmpVec2,
														defaultDimensions
													)
												}
											}
											context.restore()
			
			//								var elapsed = performance.now() - start
										}
									}
			
			//						statisticsManager.updateNode( 'platform drawing', elapsed )
								}
			
								var shape = rectangles[ id ]
			
								if( shape ) {
									drawShape.rectangle( context, shape )
								}
							}
						}
						context.restore()
					}
			
					var drawDebug = function( context, childrenComponents, debugBoxes, debugCircles, transforms, deltaTimeInMs, id ) {
						var debugBox    = debugBoxes[ id ],
							debugCircle = debugCircles[ id ],
							transform   = transforms[ id ]
			
						if( !debugBox && !debugCircle ) return
			
						context.save()
						{
							if( transform ) {
								context.setTransform( transform.worldMatrix )
							}
			
							if( debugBox ) {
								drawPhysicsBox( context, debugBox.width, debugBox.height, debugBox.color, 1 )
			
							} else {
								drawPhysicsCircle( context, debugCircle.radius, debugCircle.color, 1 )
							}
			
							context.setColor( markerColor )
							drawPhysicsPoint( context, 0.2 )
			
							context.setLineColor( markerColor )
							drawPhysicsOrigin( context, 0.25 )
						}
						context.restore()
					}
			
					var setCamera = function( context, cameraDimensions, position ) {
						// setting up the camera geometry
						var halfWidth  = cameraDimensions[ 0 ] * 0.5,
							halfHeight = cameraDimensions[ 1 ] * 0.5
			
						mathUtil.mat3Ortho( tmpMat3, -halfWidth, halfWidth, -halfHeight, halfHeight )
			
						// translating with the inverse camera position
						mat3.translate( tmpMat3, tmpMat3, vec2.negate( tmpVec2, position ) )
			
						context.setViewMatrix( tmpMat3 )
					}
			
					var initColorBuffer = function( context, screenDimensions ) {
						context.resizeColorBuffer( screenDimensions[ 0 ], screenDimensions[ 1 ] )
						context.viewport( 0, 0, screenDimensions[ 0 ], screenDimensions [ 1 ] )
					}
			
					var createViewFrustum = function( cameraDimensions, cameraTranslation ) {
						var halfCameraDimensions = vec2.scale( tmpVec2, cameraDimensions, 0.5 )
			
						vec2.subtract(
							tmpViewFrustum.bottomLeft,
							cameraTranslation,
							halfCameraDimensions
						)
			
						vec2.add(
							tmpViewFrustum.topRight,
							cameraTranslation,
							halfCameraDimensions
						)
			
						return tmpViewFrustum
					}
			
					var init = function( spell ) {
						var eventManager = this.eventManager
			
						this.screenResizeHandler = _.bind(
							function( size ) {
								this.screenSize = size
								initColorBuffer( this.context, size )
							},
							this
						)
			
						eventManager.subscribe( Events.SCREEN_RESIZE, this.screenResizeHandler )
			
			
						this.cameraChangedHandler = _.bind(
							function( camera, entityId ) {
								 currentCameraId = camera.active ? entityId : undefined
							},
							this
						)
			
						eventManager.subscribe( [ Events.COMPONENT_CREATED, Defines.CAMERA_COMPONENT_ID ], this.cameraChangedHandler )
						eventManager.subscribe( [ Events.COMPONENT_UPDATED, Defines.CAMERA_COMPONENT_ID ], this.cameraChangedHandler )
			
			
						// HACK: textAppearances should get translated when they are created or when the current language is changed
						this.translateTextAppearanceHandler = _.bind(
							translateTextAppearance,
							null,
							spell.libraryManager,
							spell.configurationManager.getValue( 'currentLanguage' )
						)
			
						eventManager.subscribe( [ Events.COMPONENT_CREATED, Defines.TEXT_APPEARANCE_COMPONENT_ID ], this.translateTextAppearanceHandler )
			
			
			//			statisticsManager = spell.statisticsManager
			//
			//			statisticsManager.addNode( 'compiling entity list', 'spell.system.render' )
			//			statisticsManager.addNode( '# entities drawn', 'spell.system.render' )
			
			//			statisticsManager.addNode( 'drawing', 'spell.system.render' )
			//			statisticsManager.addNode( 'sort', 'spell.system.render' )
			//			statisticsManager.addNode( 'platform drawing', 'drawing' )
					}
			
					var destroy = function( spell ) {
						var eventManager = this.eventManager
			
						eventManager.unsubscribe( Events.SCREEN_RESIZE, this.screenResizeHandler )
						eventManager.unsubscribe( [ Events.COMPONENT_CREATED, Defines.CAMERA_COMPONENT_ID ], this.cameraChangedHandler )
						eventManager.unsubscribe( [ Events.COMPONENT_UPDATED, Defines.CAMERA_COMPONENT_ID ], this.cameraChangedHandler )
						eventManager.unsubscribe( [ Events.COMPONENT_CREATED, Defines.TEXT_APPEARANCE_COMPONENT_ID ], this.translateTextAppearanceHandler )
			
						this.context.clear()
					}
			
					var process = function( spell, timeInMs, deltaTimeInMs ) {
						var context                = this.context,
							screenSize             = this.screenSize,
							entityManager          = spell.entityManager,
							transforms             = this.transforms,
							appearances            = this.appearances,
							textureMatrices        = this.textureMatrices,
							animatedAppearances    = this.animatedAppearances,
							textAppearances        = this.textAppearances,
							tilemaps               = this.tilemaps,
							spriteSheetAppearances = this.spriteSheetAppearances,
							childrenComponents     = this.childrenComponents,
							quadGeometries         = this.quadGeometries,
							visualObjects          = this.visualObjects,
							rectangles             = this.rectangles,
							viewFrustum
			
						// clear color buffer
						context.clear()
			
						// set the camera
						var camera          = this.cameras[ currentCameraId ],
							cameraTransform = transforms[ currentCameraId ]
			
						if( !camera || !cameraTransform ) {
							throw 'No valid camera available.'
						}
			
			
						var aspectRatio               = screenSize[ 0 ] / screenSize[ 1 ],
							effectiveCameraDimensions = createEffectiveCameraDimensions( camera.width, camera.height, cameraTransform.scale, aspectRatio )
			
						viewFrustum = createViewFrustum( effectiveCameraDimensions, cameraTransform.translation )
			
			
						// draw visual objects in background pass
						setCamera( context, effectiveCameraDimensions, [ 0, 0 ] )
			
						var visibleEntityIdsSorted = createVisibleEntityIdsSorted( spell.backgroundPassEntities )
			
						for( var i = 0, n = visibleEntityIdsSorted.length; i < n; i++ ) {
							drawVisualObject(
								entityManager,
								context,
								transforms,
								appearances,
								textureMatrices,
								animatedAppearances,
								textAppearances,
								tilemaps,
								spriteSheetAppearances,
								childrenComponents,
								quadGeometries,
								visualObjects,
								rectangles,
								deltaTimeInMs,
								visibleEntityIdsSorted[ i ],
								viewFrustum
							)
						}
			
			
						// draw visual objects in world pass
						context.save()
						{
							setCamera( context, effectiveCameraDimensions, cameraTransform.translation )
			
							visibleEntityIdsSorted = createVisibleEntityIdsSorted( spell.worldPassEntities )
			
							for( var i = 0, n = visibleEntityIdsSorted.length; i < n; i++ ) {
								drawVisualObject(
									entityManager,
									context,
									transforms,
									appearances,
									textureMatrices,
									animatedAppearances,
									textAppearances,
									tilemaps,
									spriteSheetAppearances,
									childrenComponents,
									quadGeometries,
									visualObjects,
									rectangles,
									deltaTimeInMs,
									visibleEntityIdsSorted[ i ],
									viewFrustum
								)
							}
			
							if( this.config.debug &&
								drawDebugShapes ) {
			
								var debugBoxes   = this.debugBoxes,
									debugCircles = this.debugCircles
			
								for( var i = 0, n = visibleEntityIdsSorted.length; i < n; i++ ) {
									drawDebug( context, childrenComponents, debugBoxes, debugCircles, transforms, deltaTimeInMs, visibleEntityIdsSorted[ i ] )
								}
							}
						}
						context.restore()
			
			
						// draw visual objects in ui pass
						setCamera( context, effectiveCameraDimensions, [ 0, 0 ] )
			
						visibleEntityIdsSorted = createVisibleEntityIdsSorted( spell.uiPassEntities )
			
						for( var i = 0, n = visibleEntityIdsSorted.length; i < n; i++ ) {
							drawVisualObject(
								entityManager,
								context,
								transforms,
								appearances,
								textureMatrices,
								animatedAppearances,
								textAppearances,
								tilemaps,
								spriteSheetAppearances,
								childrenComponents,
								quadGeometries,
								visualObjects,
								rectangles,
								deltaTimeInMs,
								visibleEntityIdsSorted[ i ],
								viewFrustum
							)
						}
			
						setCamera( context, effectiveCameraDimensions, cameraTransform.translation )
			
						// clear unsafe area
						if( camera &&
							camera.clearUnsafeArea &&
							cameraTransform ) {
			
							var cameraDimensions             = [ camera.width, camera.height ],
								scaledCameraDimensions       = vec2.multiply( tmpVec2, cameraDimensions, cameraTransform.scale ),
								cameraAspectRatio            = scaledCameraDimensions[ 0 ] / scaledCameraDimensions[ 1 ],
								effectiveTitleSafeDimensions = createIncludedRectangle( screenSize, cameraAspectRatio, true )
			
							vec2.scale(
								tmpVec2,
								vec2.subtract( tmpVec2, screenSize, effectiveTitleSafeDimensions ),
								0.5
							)
			
							var offset = tmpVec2
			
							offset[ 0 ] = Math.round( offset[ 0 ] )
							offset[ 1 ] = Math.round( offset[ 1 ] )
			
							context.save()
							{
								// world to view matrix
								mathUtil.mat3Ortho( tmpMat3, 0, screenSize[ 0 ], 0, screenSize[ 1 ] )
								context.setViewMatrix( tmpMat3 )
			
								context.setColor( clearColor )
			
								if( offset[ 0 ] > 0 ) {
									context.fillRect( 0, 0, offset[ 0 ], screenSize[ 1 ] )
									context.fillRect( screenSize[ 0 ] - offset[ 0 ], 0, offset[ 0 ], screenSize[ 1 ] )
			
								} else if( offset[ 1 ] > 0 ) {
									context.fillRect( 0, 0, screenSize[ 0 ], offset[ 1 ] )
									context.fillRect( 0, screenSize[ 1 ] - offset[ 1 ], screenSize[ 0 ], offset[ 1 ] )
								}
							}
							context.restore()
						}
			
						if( this.isDevelopment &&
							effectiveCameraDimensions &&
							cameraTransform ) {
			
							context.save()
							{
								if( this.configurationManager.getValue( 'drawCoordinateGrid' ) ) {
									drawCoordinateGrid( context, this.debugFontAsset, screenSize, effectiveCameraDimensions, cameraTransform )
								}
			
								if( this.configurationManager.getValue( 'drawTitleSafeOutline' ) ) {
									drawTitleSafeOutline( context, screenSize, [ camera.width, camera.height ], cameraTransform )
								}
							}
							context.restore()
						}
			
			//			var elapsed = performance.now() - start
			
			//			spell.statisticsManager.updateNode( 'drawing', elapsed )
					}
			
			
					var Render = function( spell ) {
						this.configurationManager = spell.configurationManager
						this.context              = spell.renderingContext
						this.eventManager         = spell.eventManager
						this.debugFontAsset       = spell.assetManager.get( debugFontAssetId )
						this.screenSize           = spell.configurationManager.getValue( 'currentScreenSize' )
						this.isDevelopment        = spell.configurationManager.getValue( 'mode' ) !== 'deployed'
			
						// world to view matrix
						mathUtil.mat3Ortho( tmpMat3, 0.0, this.screenSize[ 0 ], 0.0, this.screenSize[ 1 ] )
						this.context.setViewMatrix( tmpMat3 )
			
						this.context.setClearColor( clearColor )
						initColorBuffer( this.context, this.screenSize )
					}
			
					Render.prototype = {
						init : init,
						destroy : destroy,
						activate : function( spell ) {},
						deactivate : function( spell ) {},
						process : process
					}
			
					return Render
				}
			)
			
			define(
				'spell/system/visibility',
				[
					'spell/client/util/createEffectiveCameraDimensions',
					'spell/Defines',
					'spell/Events',
					'spell/math/vec2',
			
					'spell/functions'
				],
				function(
					createEffectiveCameraDimensions,
					Defines,
					Events,
					vec2,
			
					_
				) {
					'use strict'
			
			
					var init = function( spell ) {
						var eventManager = this.eventManager
			
						this.screenResizeHandler = _.bind(
							function( size ) {
								this.screenSize = size
							},
							this
						)
			
						eventManager.subscribe( Events.SCREEN_RESIZE, this.screenResizeHandler )
			
			
						this.cameraChangedHandler = _.bind(
							function( camera, entityId ) {
								this.currentCameraId = camera.active ? entityId : undefined
							},
							this
						)
			
						eventManager.subscribe( [ Events.COMPONENT_CREATED, Defines.CAMERA_COMPONENT_ID ], this.cameraChangedHandler )
						eventManager.subscribe( [ Events.COMPONENT_UPDATED, Defines.CAMERA_COMPONENT_ID ], this.cameraChangedHandler )
			
			
						this.visualObjectCreatedHandler = _.bind(
							function( entityId, entity ) {
								var visualObject = entity[ Defines.VISUAL_OBJECT_COMPONENT_ID ]
			
								if( !visualObject ||
									visualObject.pass === 'world' ) {
			
									return
								}
			
								var childrenComponent = entity[ Defines.CHILDREN_COMPONENT_ID ],
									parentComponent   = entity[ Defines.PARENT_COMPONENT_ID ]
			
								var entityInfo = {
									children : childrenComponent ? childrenComponent.ids : [],
									layer : visualObject.layer,
									id : entityId,
									parent : parentComponent ? parentComponent.id : 0
								}
			
								if( visualObject.pass === 'ui' ) {
									this.uiPassEntities[ entityId ] = entityInfo
			
								} else if( visualObject.pass === 'background' ) {
									this.backgroundPassEntities[ entityId ] = entityInfo
								}
							},
							this
						)
			
						eventManager.subscribe( [ Events.ENTITY_CREATED, Defines.VISUAL_OBJECT_COMPONENT_ID ], this.visualObjectCreatedHandler )
					}
			
					var destroy = function( spell ) {
						var eventManager = this.eventManager
			
						eventManager.unsubscribe( Events.SCREEN_RESIZE, this.screenResizeHandler )
						eventManager.unsubscribe( [ Events.COMPONENT_CREATED, Defines.CAMERA_COMPONENT_ID ], this.cameraChangedHandler )
						eventManager.unsubscribe( [ Events.COMPONENT_UPDATED, Defines.CAMERA_COMPONENT_ID ], this.cameraChangedHandler )
						eventManager.unsubscribe( [ Events.ENTITY_CREATED, Defines.VISUAL_OBJECT_COMPONENT_ID ], this.visualObjectCreatedHandler )
					}
			
			
					var process = function( spell, timeInMs, deltaTimeInMs ) {
						var currentCameraId = this.currentCameraId,
							camera          = this.cameras[ currentCameraId ],
							transform       = this.transforms[ currentCameraId ]
			
						if( !camera || !transform ) {
							return
						}
			
						var screenSize                = this.screenSize,
							aspectRatio               = screenSize[ 0 ] / screenSize[ 1 ],
							effectiveCameraDimensions = createEffectiveCameraDimensions( camera.width, camera.height, transform.scale, aspectRatio )
			
						spell.worldPassEntities = spell.entityManager.getEntityIdsByRegion( transform.translation, effectiveCameraDimensions )
						spell.uiPassEntities = this.uiPassEntities
						spell.backgroundPassEntities = this.backgroundPassEntities
					}
			
					/**
					 * Determines which entities' bounds are currently intersected or contained by the view frustum defined by the
					 * currently active camera. The result of the computation is stored in the spell object in order to make it
					 * available as input for other systems.
					 *
					 * @param spell
					 * @constructor
					 */
					var Visibility = function( spell ) {
						this.configurationManager       = spell.configurationManager
						this.eventManager               = spell.eventManager
						this.screenSize                 = spell.configurationManager.getValue( 'currentScreenSize' )
						this.currentCameraId            = undefined
						this.screenResizeHandler        = undefined
						this.cameraChangedHandler       = undefined
						this.visualObjectCreatedHandler = undefined
						this.uiPassEntities             = {}
						this.backgroundPassEntities     = {}
					}
			
					Visibility.prototype = {
						init : init,
						destroy : destroy,
						activate : function( spell ) {},
						deactivate : function( spell ) {},
						process : process
					}
			
					return Visibility
				}
			)
			

		}
	}
}
