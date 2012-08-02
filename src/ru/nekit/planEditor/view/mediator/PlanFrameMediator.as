package ru.nekit.planEditor.view.mediator
{
	
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.Keyboard;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.utils.StringUtil;
	
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import ru.nekit.planEditor.*;
	import ru.nekit.planEditor.model.*;
	import ru.nekit.planEditor.model.action.*;
	import ru.nekit.planEditor.model.clipboard.Clipboard;
	import ru.nekit.planEditor.model.dataModel.*;
	import ru.nekit.planEditor.model.definition.element.*;
	import ru.nekit.planEditor.model.definition.layer.*;
	import ru.nekit.planEditor.model.definition.plan.*;
	import ru.nekit.planEditor.model.interfaces.*;
	import ru.nekit.planEditor.model.planElement.*;
	import ru.nekit.planEditor.util.Util;
	import ru.nekit.planEditor.view.frame.PlanFrame;
	import ru.nekit.planEditor.view.plan.*;
	
	import spark.events.IndexChangeEvent;
	
	public class PlanFrameMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "PlanMediator";
		
		private static var mouseAction:MouseAction;
		private static var keyAction:KeyAction;
		private static var main:Main;
		
		public var grid:PlanGridMediator;
		public var selectionArea:SelectionAreaMediator;
		public var selectionGroup:ElementGroup;
		public var layers:LayerListMediator;
		public var clipboard:Clipboard;
		
		public var userInputEnabled:Boolean = true;
		
		public function PlanFrameMediator(viewComponent:PlanFrame)
		{
			super(viewComponent);
			initializeNotifier(PlanEditor.KEY);
			owner.setFocus();
			mouseAction 	= editor.mouseAction;
			keyAction      	= editor.keyAction;
			registerEvents();
			main 				= editor.view.owner; 
		}
		
		private function registerEvents():void
		{
			owner.addPage.addEventListener(MouseEvent.CLICK, addPageHandler);
			owner.removePage.addEventListener(MouseEvent.CLICK, removePageHandler);
			owner.pageList.addEventListener(IndexChangeEvent.CHANGING, pageSelectHandler);	
		}
		
		private function addPageHandler(event:MouseEvent):void
		{
			sendNotification(NAMES.ADD_PAGE, editor.model.pagesData.next);
		}
		
		private function removePageHandler(event:MouseEvent):void
		{
			sendNotification(NAMES.REMOVE_PAGE);
		}
		
		private function pageSelectHandler(event:IndexChangeEvent):void
		{
			if( event.newIndex == -1 )
			{
				event.preventDefault();
				event.newIndex = 0;
			}
			else
				sendNotification(NAMES.SELECT_PAGE, editor.model.pagesData.get(event.newIndex));
		}
		
		override public function listEventInterests():Array
		{
			return [
				MouseEvent.MOUSE_DOWN,
			];
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				NAMES.KEY_DOWN,
				NAMES.MOUSE_MOVE,
				NAMES.MOUSE_UP,
				NAMES.REGISTER_LAYER,
				NAMES.SET_ADDRESS,
				NAMES.SET_CURRENT_LAYER,
				NAMES.SELECT_LAYER,
				NAMES.ADD_PAGE,
				NAMES.REMOVE_PAGE,
				NAMES.SET_CURRENT_PAGE,
				NAMES.SELECT_PAGE,
				NAMES.COPY,
				NAMES.PASTE,
				NAMES.ADD_ELEMENT,
				NAMES.ADD_ELEMENT_MANUAL,
				NAMES.PLAN_SET_FOCUS,
				NAMES.CLEAR_PLAN,
				NAMES.SET_PLAN_ORIENTATION,
				NAMES.UPDATE_PLAN_EDIT_MODE,
			]
		}
		
		public function get owner():PlanFrame
		{
			return viewComponent as PlanFrame;
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
			var body:Object = notification.body;
			
			var i:uint;
			var length:uint;
			var elementLength:uint;
			var element:BaseElement; 
			var elements:Vector.<BaseElement>
			var x:Number;
			var y:Number;
			
			var layerD:LayerDefinition;
			var pageD:PageDataItem;
			var elementD:ElementDefinition;
			
			const layerDL:LayerDefinitionList 			= editor.model.layersDefinition;
			const elementDL:ElementDefinitionList 	= editor.model.elementsDefinition;
			const pageDL:PageDataItemList			= editor.model.pagesData;
			
			switch ( notification.name )
			{
				
				case NAMES.CLEAR_PLAN:
					
					BaseElement.idCount = 0;
					if( pageDL.current )
					{
						selectionGroup.clear();
						elements 								= pageDL.current.elements;
						length 									= elements.length;
						for( i = 0; i < length; i++)
							elements[i].remove();
						pageDL.clear();
					}
					
					break;
				
				case NAMES.ADD_PAGE:
					
					pageD	= body as PageDataItem;
					pageDL.add(pageD);
					length	= layerDL.length;
					for(   i 	= 0 ; i < length; i++ )
					{
						layerD = layerDL.get(i);
						if( layerD.id != LayerDefinition.ALL )
							pageD.add(layerD);
					}
					owner.pageList.dataProvider = new ArrayCollection( pageDL.toArray() );
					pageD.current							= layerDL.current;
					
					break;
				
				case NAMES.REMOVE_PAGE:
					
					var removePage:Function = function ():void
					{
						elements														= pageDL.current.elements;
						length 															= elements.length;
						for( i = 0; i < length; i++)
							elements[i].remove();
						pageDL.remove(pageDL.current);
						owner.pageList.dataProvider = new ArrayCollection( pageDL.toArray() );
						sendNotification(NAMES.SELECT_PAGE, pageDL.last);	
					}
					
					if( pageDL.current.elements.length == 0 )
					{
						if( pageDL.length == 1)
							pageDL.current.clear();
						else
							removePage();
					}
					else
						if( pageDL.length == 1 )	
							Alert.show("Очистить страницу?", "Предупреждение", Alert.YES | Alert.NO, owner, 
								function (event:CloseEvent):void
								{
									if( event.detail == Alert.YES )
									{
										elements														= pageDL.current.elements;
										length 															= elements.length;
										for( i = 0; i < length; i++)
											elements[i].remove();
										pageDL.remove(pageDL.current);
										pageD	= pageDL.first;
										length	= layerDL.length;
										for(   i 	= 0 ; i < length; i++ )
										{
											layerD = layerDL.get(i);
											if( layerD.id != LayerDefinition.ALL )
												pageD.add(layerD);
										}
									}
								}
							);
						else
							Alert.show("Удалить страницу?", "Предупреждение", Alert.YES | Alert.NO, owner, 
								function (event:CloseEvent):void
								{
									if( event.detail == Alert.YES )
										removePage();
								}
							);
					
					break;
				
				case NAMES.SET_CURRENT_PAGE:
					
					pageD								= body as PageDataItem;
					pageDL.current 				= layers.page 	= pageD;
					pageDL.current.current 	= layerDL.current;
					
					break;
				
				case NAMES.SELECT_PAGE:
					
					pageD																= body as PageDataItem;
					selectionGroup.clear();
					if( pageDL.current != pageD )
					{
						elements														= pageDL.current.elements;
						length 															= elements.length;
						for( i = 0; i < length; i++)
							elements[i].remove();
					}
					
					pageDL.current 												= owner.pageList.selectedItem = layers.page = pageD;
					pageDL.current.current 									= layerDL.current;
					length 																= layerDL.length;
					for( i = 0; i < length; i++ )
					{
						layerD = layerDL.get(i);
						if( layerD.id == LayerDefinition.ALL ) continue;
						elements 		= pageDL.current.get(layerD).elements;
						elementLength		= elements.length;
						for( var j:uint     = 0 ; j < elementLength ; j++ )
							editor.model.layerDefinitionLink.getLayerMediator(  layerD ).addElement(elements[j]);
					}
					
					break;
				
				case NAMES.REGISTER_LAYER:
					
					var layer:LayerMediator;
					layerD = body as LayerDefinition;
					if( layerD.id != LayerDefinition.ALL /*&& layerD.active*/ )
					{
						layer 						= layers.registerLayer(layerD);
						editor.model.layerDefinitionLink.add(layerD, layer);
						layer.owner.visible 	= layer.owner.enabled 
							= layerD.active;
					}
					
					break;
				
				case NAMES.SET_CURRENT_LAYER:
					
					layerD 										= body as LayerDefinition;
					if( layerDL.current != layerD )
					{
						layerDL.current 					= layerD;
						layers.current 						= editor.model.layerDefinitionLink.getLayerMediator(  layerD );
						if( pageDL.current )
							pageDL.current.current	= layerD;
					}
					
					break;
				
				case NAMES.SELECT_LAYER:
					
					layerD 													= body as LayerDefinition;
					if( layerDL.current != layerD )
					{
						trace("Select Layer: "+ layerD.id);
						selectionGroup.clear();	
						layerDL.current 									= layerD;
						layers.current 										= editor.model.layerDefinitionLink.getLayerMediator(  layerD );
						if( pageDL.current )
							pageDL.current.current					= layerD;
						var _layerD:LayerDefinition;
						length 													= layerDL.length;
						if( layerD.id == LayerDefinition.ALL )
							for( i = 0; i < length; i++)
							{
								_layerD = layerDL.get(i);
								if(  _layerD.active && _layerD.id != LayerDefinition.ALL )
									with( editor.model.layerDefinitionLink.getLayerMediator( _layerD ) )
									{
										enabled	 		= true;
										owner.depth 	= _layerD.depth;
									}
							}
						else
						{
							var maxDepth:uint = 0;
							for( i = 0; i < length; i++)
							{
								_layerD = layerDL.get(i);
								if( _layerD.active && _layerD.id != LayerDefinition.ALL )
								{
									editor.model.layerDefinitionLink.getLayerMediator(  _layerD ).owner.depth = _layerD.depth;
									maxDepth = Math.max(maxDepth, _layerD.depth);
								}
							}
							maxDepth++;
							if( pageDL.current )
								pageDL.current.current						= layerD;
							with( editor.model.layerDefinitionLink.getLayerMediator(  layerD ) )
							{
								enabled 			= true;
								owner.depth 	= maxDepth;
							}
							for( i = 0; i < length; i++)
							{
								_layerD = layerDL.get(i);
								if( _layerD.active && _layerD != layerD && _layerD.id != LayerDefinition.ALL )
									editor.model.layerDefinitionLink.getLayerMediator( _layerD ).enabled = false;
							}
						}
					}
					
					break;
				
				case NAMES.ADD_ELEMENT:
					
					element = body as BaseElement;
					pageDL.addElement(element);
					
					break;
				
				case NAMES.ADD_ELEMENT_MANUAL:
					
					if( layerDL.current.active )
					{
						element = body as BaseElement;
						element.configByDefinition(editor.model.configDefinition.elementsDefinition.getByClass(getQualifiedClassName(element)));
						pageDL.addElement(element);
						layers.current.addElement(element);
						selectionGroup.updateDimension();
						x = selectionGroup.x;
						y = selectionGroup.y;
						if( selectionGroup.length == 0 )
						{
							element.x = cellSizeX;
							element.y = cellSizeY;
						}
						else
						{
							element.x = x + selectionGroup.width;
							element.y = y;
						}
						selectionGroup.clear();
						selectionGroup.addElement(element);
						if( element is ILabel )
							ILabel(element).setFocus();
					}
					
					break;
				
				case NAMES.KEY_DOWN:
					
					if( owner.focusEnabled && userInputEnabled)
					{
						
						switch( editor.keyAction.keyCode ){
							
							case Keyboard.LEFT:
								
								if( keyAction.altKey )
								{
									if( keyAction.ctrlKey )
										selectionGroup.addWidth = cellSizeX;
									selectionGroup.x -= cellSizeX;
								}
								else
								{
									if( keyAction.ctrlKey )
										selectionGroup.addWidth = -cellSizeX;
									else
										selectionGroup.x -= cellSizeX;
								}
								
								break;
							
							case Keyboard.RIGHT:
								
								if( keyAction.altKey )
								{
									if( keyAction.ctrlKey )
										selectionGroup.addWidth = -cellSizeX;
									selectionGroup.x += cellSizeX;
								}
								else
								{
									if( keyAction.ctrlKey )
										selectionGroup.addWidth = cellSizeX;
									else
										selectionGroup.x += cellSizeX;
								}
								
								break;
							
							case Keyboard.DOWN:
								
								if( keyAction.altKey )
								{
									if( keyAction.ctrlKey )
										selectionGroup.addHeight = cellSizeY;
								}
								else
								{
									if( keyAction.ctrlKey )
									{
										selectionGroup.addHeight = -cellSizeY;
										selectionGroup.y += cellSizeY;
									}else
										selectionGroup.y += cellSizeY;
								}
								
								break;
							
							case Keyboard.UP:
								
								if( keyAction.altKey )
								{
									if( keyAction.ctrlKey )
										selectionGroup.addHeight = -cellSizeY;
								}
								else
								{
									if( keyAction.ctrlKey )
										selectionGroup.addHeight = cellSizeY;
									selectionGroup.y -= cellSizeY;
								}
								
								break;
							
							case Keyboard.BACKSPACE:
							case Keyboard.DELETE:
								
								length = selectionGroup.length;
								for( i = 0; i < length; i++)
								{
									element= selectionGroup.getElement(i);
									element.remove();
									layerD = editor.model.layerDefinitionLink.getLayerDefinition(element.layer);
									pageDL.current.get(layerD).remove(element);
								}
								selectionGroup.clear();
								
								break;
							
							case Keyboard.A:
								
								if( keyAction.ctrlKey )
								{
									//select all
								}
								
								break;
							
							default:
								break;
							
						}
						
					}
					break;
				
				case NAMES.COPY:
					
					if( owner.focusEnabled && userInputEnabled )
					{
						if( selectionGroup.length > 0 )
							clipboard.add(selectionGroup);
						if(  editor.keyAction.keyCode == Keyboard.X )
						{
							length = selectionGroup.length;
							for( i = 0; i < length; i++)
								selectionGroup.getElement(i).remove();
							selectionGroup.clear();
						}
					}
					
					break;
				
				case NAMES.PASTE:
					
					if( owner.focusEnabled && userInputEnabled )
					{
						if( body )
						{
							x = mouseAction.x;
							y = mouseAction.y;
						}
						else
						{
							x = selectionGroup.x;
							y = selectionGroup.y;
						}
						selectionGroup.clear();
						if( clipboard.length > 0 )
						{
							//get original element group with out copy
							var clipboardElement:ElementGroup 	= clipboard.get(true);
							var flatLength:uint 							= 0;
							length 													= clipboardElement.length;
							for( i = 0; i < length; i++)
								if( clipboardElement.getElement(i) is FlatElement && StringUtil.trim(FlatElement(clipboardElement.getElement(i)).label) != "" )
									flatLength++;
							for( i = 0; i < length; i++)
							{
								//copy element
								element = clipboardElement.getElement(i).copy();
								try
								{
									layerD = layerDL.current;
									if( layerD.id != LayerDefinition.ALL )
									{
										if( editor.model.layerDefinitionLink.getLayerDefinition( element.layer ) != layerDL.current )
										{
											if( elementDL.getByClass(getQualifiedClassName(element)).resolveInLayers.indexOf( layerD ) != -1)
												layerD 				= elementDL.getByClass(getQualifiedClassName(element)).mainLayer;
											else
												continue;
										}
									}
									else
									{
										if( elementDL.getByClass(getQualifiedClassName(element)).resolveInLayers.indexOf( element.layer ) == -1)
											layerD 				= elementDL.getByClass(getQualifiedClassName(element)).mainLayer;
									}
								}
								catch(error:Error){
								}
								element.id = null;
								selectionGroup.addElement(element.add());
								pageDL.current.get(layerD).add(element);
								if( element is FlatElement )
								{
									var flatNumber:Number = parseInt(FlatElement(element).label);
									if( !isNaN(flatNumber) )
										FlatElement(clipboardElement.getElement(i)).label = FlatElement(element).label = ( flatNumber + flatLength ).toString(); 
								}
							}
							if( keyAction.altKey )
							{
								selectionGroup.x = mouseAction.x;
								selectionGroup.y = mouseAction.y;
							}
							else
							{
								selectionGroup.x = x;
								selectionGroup.y = y - selectionGroup.height;
							}
						}
					}
					
					break;
				
				case NAMES.MOUSE_MOVE:
					
					mouseAction.x =  owner.layerList.mouseX;
					mouseAction.y =  owner.layerList.mouseY;
					if( mouseAction.selectionStatus == MouseAction.PREACTIVE )
						mouseAction.selectionStatus = MouseAction.ACTIVE;
					else if( mouseAction.selectionStatus == MouseAction.ACTIVE )
						sendNotification(NAMES.SELECTION_AREA_UPDATE);
					else if( mouseAction.selectionStatus == MouseAction.SELECT_OBJECT && userInputEnabled )
						selectionGroup.doDrag();
					mouseAction.event.updateAfterEvent();
					
					break;
				
				case NAMES.MOUSE_UP:
					
					if( mouseAction.selectionStatus == MouseAction.ACTIVE )
					{
						owner.setFocus();
						sendNotification(NAMES.SELECTION_AREA_CLEAR);	
						elements 					= pageDL.current.elements;
						elementLength			= elements.length;
						for(  i = 0 ; i < elementLength;  i++ )
						{
							layerD = editor.model.layerDefinitionLink.getLayerDefinition( elements[i].layer );
							if( layerD.active && layerD.editable && elements[i].layer.enabled  && Util.isIntersect(elements[i].dimension, mouseAction.selectionBounds) )
							{
								elements[i].selected = true;
								selectionGroup.addElement(elements[i]);
							}
						}
					}
					else
						if( mouseAction.selectionStatus == MouseAction.SELECT_OBJECT )
							selectionGroup.stopDrag();		
					
					mouseAction.selectionStatus = null;
					
					break;
				
				case NAMES.PLAN_SET_FOCUS:
					
					var focused:Boolean = body as Boolean;
					owner.focusEnabled = focused;
					if( focused )
						owner.setFocus();
					
					break;
				
				case NAMES.UPDATE_PLAN_EDIT_MODE:
					
					owner.planContainer.mouseChildren = owner.planContainer.mouseEnabled = owner.planContainer.mouseFocusEnabled = userInputEnabled = PlanEditMode.isEditMode;
					owner.pageControl.visible = owner.pageControl.includeInLayout = PlanEditMode.mode == PlanEditMode.EDIT_MODE;
					
					break;
				
				case NAMES.SET_PLAN_ORIENTATION:
					
					var value:PlanOrientationDefinitionItem 	= body as PlanOrientationDefinitionItem;
					owner.planContainer.width 						= value.width;
					owner.planContainer.height						= value.height;
					grid.owner.init(owner.planContainer.width, owner.planContainer.height, 5, 5); 
					selectionGroup.bounds 								= dimension;
					
					break;
				
				case NAMES.SET_ADDRESS:
					
					var address:AddressDataItem = body as AddressDataItem;
					owner.address.text 	=  address.street.name + "  " + address.building.number;
					owner.address.visible = true;
					
					break;
				
				default:
					break;
			}
		}
		
		override public function handleEvent(event:Event):void
		{
			var target:Object 						= event.target;
			mouseAction.event						= event as MouseEvent;
			switch ( event.type )
			{
				
				case MouseEvent.MOUSE_DOWN:
					
					if( !editor.keyAction.altKey )
					{
						owner.setFocus();
						if( target is ISelectable )
						{
							if( target is BaseElement )
							{
								var element:BaseElement = target as BaseElement;
								if( element.layer.enabled && editor.model.layerDefinitionLink.getLayerDefinition( element.layer ).editable )
								{
									mouseAction.selectionStatus = MouseAction.SELECT_OBJECT;
									if( editor.keyAction.shiftKey )
										element.selected = !element.selected;
									else
									{
										if( !element.selected )
											selectionGroup.clear();
										element.selected = true;
									}
									if( element.selected )
									{
										Util.setOnTop(element);
										selectionGroup.addElement(element);
									}
									else
										selectionGroup.removeElement(element);
								}
								else
								{
									mouseAction.selectionStatus = MouseAction.PREACTIVE;
									selectionGroup.clear();
								}
							}
						}
						else if( target == grid.owner || target == owner.rootPlanContainer )
						{
							mouseAction.selectionStatus = MouseAction.PREACTIVE;
							if( !editor.keyAction.shiftKey )
								selectionGroup.clear();
						}
					}
					else
					{
						mouseAction.selectionStatus = MouseAction.PREACTIVE;
						if( !editor.keyAction.shiftKey )
							selectionGroup.clear();
					}
					mouseAction.startX = mouseAction.x = owner.layerList.mouseX;
					mouseAction.startY = mouseAction.y = owner.layerList.mouseY;
					
					break;
				
				default:
					break;
			}
		}
		
		public function get dimension():Rectangle
		{
			return new Rectangle(0, 0, owner.planContainer.width*(1/owner.layerList.scaleX), owner.planContainer.height*(1/owner.layerList.scaleY));
		}
		
		public function set cellSizeX(value:Number):void
		{
			grid.owner.cellSizeX = value;
			dispatchEvent(new Event("cellSizeXChanged"));
		}
		
		[Bindable(cellSizeXChanged)]
		public function get cellSizeX():Number
		{
			return grid.owner.cellSizeX;
		}
		
		public function set cellSizeY(value:Number):void
		{
			grid.owner.cellSizeY = value;
			dispatchEvent(new Event("cellSizeYChanged"));
		}
		
		[Bindable(cellSizeYChanged)]
		public function get cellSizeY():Number
		{
			return grid.owner.cellSizeY;
		}
		
		public function set scale(value:Number):void
		{
			if( value >= .5 )
			{
				owner.rootPlanContainer.scaleX = owner.rootPlanContainer.scaleY = value;
				selectionGroup.bounds 	= dimension;
				//owner.scaleLabel.text 	= (Math.round(owner.layerList.scaleX*10)/10).toString();
			}
		}
		
		public function get scale():Number
		{
			return owner.layerList.scaleX;
		}
		
		private function createContextMenu():void
		{
			var cm:ContextMenu 				= new ContextMenu;
			var copy:ContextMenuItem 	= new ContextMenuItem("Копировать\u00A0");
			var past:ContextMenuItem 	= new ContextMenuItem("Вставить\u00A0");
			copy.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, function(event:ContextMenuEvent):void
			{
				sendNotification(NAMES.COPY);
			});
			past.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, function(event:ContextMenuEvent):void
			{
				sendNotification(NAMES.PASTE, true);
			});
			cm.customItems.push(copy);
			cm.customItems.push(past);
			cm.clipboardMenu 					= false
			cm.hideBuiltInItems();
			owner.contextMenu 				= cm;
		}
		
		private function createScaleMenu():void
		{
			main.scaleChoice.dataProvider = new ArrayCollection(
				[
					{ label: "70%", scale: .7},
					{ label: "100%", scale: 1},
					{ label: "140%", scale: 1.4},
					{ label: "200%", scale: 2},
				]	
			);
			with(main.scaleChoice )
			{
				labelField = "label";
				addEventListener(IndexChangeEvent.CHANGE, scaleChoiceHandler);
				selectedIndex = 1;
				textInput.editable = false;
				textInput.selectable = false;
			}
			
			scale = 1;
		}
		
		private function scaleChoiceHandler(event:IndexChangeEvent):void
		{
			scale = main.scaleChoice.selectedItem.scale;
		}
		
		override public function onRegister():void
		{
			grid 					= editor.registerMediator(new PlanGridMediator(owner.grid), 							PlanGridMediator.NAME) 			as PlanGridMediator
			layers   			= editor.registerMediator(new LayerListMediator(owner.layerList), 					LayerListMediator.NAME) 			as LayerListMediator;
			selectionArea 	= editor.registerMediator(new SelectionAreaMediator(owner.selectionArea), 	SelectionAreaMediator.NAME) 	as SelectionAreaMediator;
			clipboard     		= new Clipboard;
			selectionGroup	= new  ElementGroup;
			sendNotification(NAMES.SET_PLAN_ORIENTATION, PlanOrientationDefinition.A4Album);
			createContextMenu();
			createScaleMenu();
		}
	}
}