package ru.nekit.planEditor.view.mediator
{
	
	import com.asual.swfaddress.SWFAddress;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.ui.Keyboard;
	
	import mx.collections.XMLListCollection;
	import mx.controls.Alert;
	import mx.core.FTETextField;
	import mx.core.FlexGlobals;
	import mx.core.UIFTETextField;
	import mx.events.CloseEvent;
	import mx.events.MenuEvent;
	import mx.managers.SystemManager;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import ru.nekit.planEditor.NAMES;
	import ru.nekit.planEditor.PlanEditor;
	import ru.nekit.planEditor.model.PlanEditMode;
	import ru.nekit.planEditor.model.dataModel.AddressDataItem;
	import ru.nekit.planEditor.model.dataModel.PlanDataItem;
	import ru.nekit.planEditor.model.definition.layer.LayerDefinition;
	import ru.nekit.planEditor.model.definition.plan.PlanOrientationDefinition;
	
	import spark.components.RichEditableText;
	import spark.components.TextInput;
	
	public class ApplicationMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "ApplicationMediator";
		
		[Bindable]
		public var plan:PlanFrameMediator;
		public var tool:ToolMediator;
		public var elementTool:ElementToolMediator;
		public var layersTool:LayersToolMediator;
		public var elementProperty:ElementPropertyMediator;
		public var popUp:PopUpMediator;
		
		private const menuData:Array =	
			new Array(
				new XMLList(<><menu label="Файл">
				   <item id="open" 	label="Открыть план" 		toggled="false"/>
					<item id="copy from" 	label="Скопировать план из.." 	toggled="false" enabled="true"/>
				   <item id="save" 	label="Сохранить план" 	toggled="false"/>
					<!--<item id="save as" 	label="Сохранить план как..." 	toggled="false"/>-->
			   </menu>
			   <menu label="План">
				   <menu id="orientation" label="Ориентация" toggled="false"/>
			   </menu>
		   </>)
				,
				new XMLList(<><menu label="Файл">
					  <item id="open" 	label="Открыть план" 		toggled="false"/>
				  </menu>
				  <!--<menu label="План">
					  <menu id="orientation" label="Ориентация" toggled="false"/>
				  </menu>-->
			  </>)
				,
				new XMLList(<><menu label="Файл">
					  <item id="open" 	label="Открыть план" 		toggled="false"/>
					  <item id="save" 	label="Сохранить план" 	toggled="false"/>
				  </menu>
			  </>)
			);
		
		private var needOpenAfterSave:Boolean 	= false;
		private var startupComplete:Boolean 			= false;
		private var addressStringLoadPath:String;
		
		public function ApplicationMediator(viewComponent:Main)
		{
			super(viewComponent);
			initializeNotifier(PlanEditor.KEY);
			SWFAddress.setHistory(false);
			SWFAddress.onChange = changeAddresslFunction;
		}
		
		private function registerEvents():void
		{
			owner.systemManager.addEventListener(FocusEvent.FOCUS_IN,
				function(event:FocusEvent):void{
					if( isTextInputType( event.target ) )
						sendNotification(NAMES.PLAN_SET_FOCUS, false);
				}
			);
			owner.systemManager.addEventListener(FocusEvent.FOCUS_OUT,
				function(event:FocusEvent):void{
					if( isTextInputType( event.target ) )
						sendNotification(NAMES.PLAN_SET_FOCUS, true);
				}
			);
			owner.plan.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,
				function(event:FocusEvent):void{
						sendNotification(NAMES.PLAN_SET_FOCUS, true);
				}
			);
			owner.editAction.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void
			{
				PlanEditMode.mode = PlanEditMode.EDIT_MODE;
				sendNotification(NAMES.OPEN_READ_DIALOG);
			}
			);
			owner.showAction.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void
			{
				PlanEditMode.mode = PlanEditMode.READ_ONLY_MODE;
				sendNotification(NAMES.OPEN_READ_DIALOG);
			}
			)
			owner.editCouplerAction.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void
			{
				PlanEditMode.mode = PlanEditMode.EDIT_COUPLET_MODE;
				sendNotification(NAMES.OPEN_READ_DIALOG);
			}
			)
			owner.fullscreen.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void
			{
				ExternalInterface.call("fullscreenCall",  owner.fullscreen.selected);
			}
			);
		}
		
		override public function listEventInterests():Array
		{
			return [
				KeyboardEvent.KEY_DOWN,
				KeyboardEvent.KEY_UP,
				MouseEvent.MOUSE_MOVE,
				MouseEvent.MOUSE_UP,
				MouseEvent.MOUSE_DOWN,
				Event.ACTIVATE,
				Event.COPY,
				Event.PASTE,
			];
		}
		
		public function changeAddresslFunction():void
		{
			var pathNames:Array =  SWFAddress.getPathNames();
			if( pathNames.length > 0 )
			{
				addressStringLoadPath = pathNames[0];
				if( startupComplete )
					loadFromAddressLine();
			}
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				NAMES.STARTUP_COMPLETE,
				NAMES.SERIALIZE_COMPLETE,
				NAMES.CLEAR_ALL,
				NAMES.SET_ADDRESS,
				NAMES.SET_PLAN_ORIENTATION_MANUAL,
				NAMES.DATA_READ_STREETS_SUCCESS,
				NAMES.DATA_SAVE_PLAN,
				NAMES.DATA_SAVE_PLAN_SUCCESS,
				NAMES.DATA_READ_PLAN,
				NAMES.DATA_READ_PLAN_SUCCESS,
				NAMES.DATA_ADDRESS_READ_SUCCESS,
				NAMES.DATA_ADDRESS_READ_FAILURE,
				NAMES.OPEN_READ_DIALOG_OK,
			]
		}
		
		override public function handleEvent(event:Event):void
		{
			var target:Object = event.target;
			if( PlanEditMode.mode == PlanEditMode.EDIT_MODE )
			{
				switch( event.type )
				{
					
					case Event.COPY:
						
						sendNotification(NAMES.COPY);
						
						break;
					
					case Event.PASTE:
						
						sendNotification(NAMES.PASTE);
						
						break;
					
					case KeyboardEvent.KEY_DOWN:
						
						editor.keyAction.event = event as KeyboardEvent;
						sendNotification(NAMES.KEY_DOWN, editor.keyAction);
						if( editor.keyAction.ctrlKey && editor.keyAction.keyCode == Keyboard.S )
						{
							sendNotification(NAMES.SERIALIZE_COMMAND);
							//if( !planData.equal( currentPlanData ) )
							sendNotification(NAMES.DATA_SAVE_PLAN);
						}
						
						break;
					
					case KeyboardEvent.KEY_UP:
						
						editor.keyAction.event = null;
						
						break;
					
					case Event.ACTIVATE:
						
						owner.setFocus();
						
						break;
					
					case MouseEvent.MOUSE_MOVE:
						
						editor.mouseAction.event = event as MouseEvent;
						sendNotification(NAMES.MOUSE_MOVE, editor.mouseAction);
						
						break;
					
					case MouseEvent.MOUSE_UP:
						
						editor.mouseAction.event = event as MouseEvent;
						sendNotification(NAMES.MOUSE_UP, editor.mouseAction);
						
						break;
					
					default:
						break;
					
				}
			}
		}
		
		public function get planData():PlanDataItem
		{
			return editor.model.planData;
		}
		
		public function get currentPlanData():PlanDataItem
		{
			return editor.model.currentPlanData;
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var body:Object = notification.body;
			
			switch( notification.name )
			{
				
				case NAMES.DATA_SAVE_PLAN:
					
					planData.set( currentPlanData );
					planData.address.street.set(currentPlanData.address.street);
					planData.address.building.set(currentPlanData.address.building);
					sendNotification(NAMES.DATA_COMMAND, planData, NAMES.DATA_SAVE_PLAN);
					
					break;
				
				case NAMES.DATA_READ_STREETS_SUCCESS:
					
					editor.model.streetList.setData(body);
					
					break;
				
				case NAMES.DATA_READ_BUILDINGS_SUCCESS:
					
					break;
				
				case NAMES.DATA_READ_PLAN:
					
					sendNotification(NAMES.DATA_COMMAND, body, NAMES.DATA_READ_PLAN);
					
					break;
				
				case NAMES.DATA_READ_PLAN_SUCCESS:
					
					currentPlanData.setData(new XML(body));
					planData.set(currentPlanData);
					planData.address.set(currentPlanData.address);
					sendNotification(NAMES.CLEAR_PLAN);
					var layerD:LayerDefinition;
					if( PlanEditMode.mode == PlanEditMode.EDIT_COUPLET_MODE )
						layerD = editor.model.layersDefinition.getByID("ctv-layer");
					else
						layerD = editor.model.layersDefinition.current;
					sendNotification(NAMES.DESERIALIZE_COMMAND, planData, NAMES.DESERIALIZE_PLAN);
					if( layerD )
						sendNotification(NAMES.SELECT_LAYER, layerD);	
					sendNotification(NAMES.SELECT_PAGE, editor.model.pagesData.first);
					owner.wellcome.displayPopUp = false;
					sendNotification(NAMES.CLOSE_DIALOG);
					
					break;
				
				case NAMES.SET_ADDRESS:
					
					currentPlanData.address.set( body as AddressDataItem );
					owner.addressContainer.visible 	= true;
					owner.address.text 					= currentPlanData.address.street.name + "  " + currentPlanData.address.building.number;
					
					break;
				
				case NAMES.CLEAR_ALL:
					
					owner.addressContainer.visible = false;
					sendNotification(NAMES.CLEAR_PLAN);
					sendNotification(NAMES.SERIALIZE_COMMAND);
					//clear head
					planData.clear();
					//set data to default
					planData.set( currentPlanData );
					
					break;	
				
				case NAMES.STARTUP_COMPLETE:
					
					startupComplete = true;
					sendNotification(NAMES.SERIALIZE_COMMAND);
					planData.clear();
					planData.set( currentPlanData );
					if( addressStringLoadPath == null || addressStringLoadPath == "" )
					{
						if( editor.model.authLevel == 0)
						{
							owner.wellcome.displayPopUp = true;
						}
						else
						{
							owner.main.enabled = true;
							sendNotification(NAMES.OPEN_READ_DIALOG, true);
						}
					}
					loadFromAddressLine();
					
					
					break;
				
				case NAMES.SERIALIZE_COMPLETE:
					
					currentPlanData.setData( body as XML );
					
					break;
				
				break;
				
				case NAMES.DATA_SAVE_PLAN_SUCCESS:
					
					if( needOpenAfterSave )
						owner.callLater(function():void
						{
							sendNotification(NAMES.OPEN_READ_DIALOG);
							needOpenAfterSave = false;
						}
						);
					
					break;
				
				case NAMES.SET_PLAN_ORIENTATION_MANUAL:
					
					var orientation:String = body as String;
					if( orientation == PlanOrientationDefinition.A4Album.id )
						sendNotification(NAMES.SET_PLAN_ORIENTATION, currentPlanData.orientation = PlanOrientationDefinition.A4Album);
					else	if( orientation == PlanOrientationDefinition.A4Portrait.id )
						sendNotification(NAMES.SET_PLAN_ORIENTATION, currentPlanData.orientation = PlanOrientationDefinition.A4Portrait);
					
					break;
				
				case NAMES.OPEN_READ_DIALOG_OK:
					
					owner.wellcome.displayPopUp 			= false;
					owner.main.enabled 							= true;
					tool.owner.visible 					 			= PlanEditMode.mode != PlanEditMode.EDIT_COUPLET_MODE;
					elementTool.owner.includeInLayout 	= PlanEditMode.mode != PlanEditMode.READ_ONLY_MODE;
					elementTool.owner.visible		    		= elementProperty.owner.visible = PlanEditMode.isEditMode;
					initMenuBar();
					if( PlanEditMode.isEditMode )
						elementProperty.show();
					tool.show();
					sendNotification(NAMES.UPDATE_PLAN_EDIT_MODE);
					
					
					break;
				
				case NAMES.DATA_ADDRESS_READ_SUCCESS:
					
					sendNotification(NAMES.SET_ADDRESS, body);
					
					break;
				
				case NAMES.DATA_ADDRESS_READ_FAILURE:
					
					if( body == null )
					{
						owner.wellcome.displayPopUp 	= true;
						Alert.show("Адрес не найден", "Предупреждение");
						owner.address.text = "Адрес не найден";
					}
					
					break;
				
				default:
					break;
				
			}	
		}
		
		private static function isTextInputType(target:Object):Boolean
		{
			return target is RichEditableText || target is TextInput || target is UIFTETextField || target is FTETextField || target is mx.controls.TextInput;
		}
		
		public function get topLevel():SystemManager
		{
			return FlexGlobals.topLevelApplication.parent as SystemManager;
		}
		
		public function get owner():Main
		{
			return viewComponent as Main;
		}
		
		private function loadFromAddressLine():void
		{
			if( addressStringLoadPath )
			{
				var go:Boolean = true;
				sendNotification(NAMES.SERIALIZE_COMMAND);
				if( !planData.equal( currentPlanData ) && !PlanEditMode.isReadOnlyMode )
				{
					go = false;
					Alert.show("Сохранить план?", "Предупреждение", Alert.YES | Alert.NO | Alert.CANCEL, owner, 
						function (event:CloseEvent):void
						{
							if( event.detail == Alert.NO  )
								loadFromAddressLine();
							else if( event.detail == Alert.YES )
							{
								sendNotification(NAMES.DATA_SAVE_PLAN);
								loadFromAddressLine();
							}
						}
					);
				}
				if( go )
				{
					var delimiter:int				= addressStringLoadPath.indexOf(":");
					if( delimiter > 0 )
					{
						var command:String 					= addressStringLoadPath.substring(0, delimiter);
						var number:int 							= int(addressStringLoadPath.substring(delimiter + 1));
						var address:AddressDataItem	= new AddressDataItem();
						addressStringLoadPath				= null;
						address.building.id						= number;
						if( command == "edit")
							PlanEditMode.mode 				= PlanEditMode.EDIT_MODE;	
						else if( command == "view")
							PlanEditMode.mode 				= PlanEditMode.READ_ONLY_MODE;	
						else	if( command == "coupler")
							PlanEditMode.mode 				= PlanEditMode.EDIT_COUPLET_MODE;	
						else
						{
							Alert.show("Неверная команда: " + command, "Предупреждение");
							return;
						}
						sendNotification(NAMES.DATA_COMMAND, number, NAMES.DATA_ADDRESS_READ);
						sendNotification(NAMES.OPEN_READ_DIALOG_OK);
						sendNotification(NAMES.SET_ADDRESS, address);
						sendNotification(NAMES.DATA_READ_PLAN, address);
					}
				}
			}
		}
		
		override public function onRegister():void
		{
			
			plan 						= new PlanFrameMediator(owner.plan);
			tool						= new ToolMediator(owner.tool);
			elementTool  		= new ElementToolMediator(owner.tool.elementTool);
			layersTool 			= new LayersToolMediator(owner.tool.layersTool);
			elementProperty = new ElementPropertyMediator(owner.elementProperty);
			popUp					= new PopUpMediator;
			
			editor.registerMediator(plan,						PlanFrameMediator.NAME);
			editor.registerMediator(tool, 						ToolMediator.NAME);
			editor.registerMediator(elementTool, 		ElementToolMediator.NAME);
			editor.registerMediator(layersTool, 			LayersToolMediator.NAME);
			editor.registerMediator(elementProperty, 	ElementPropertyMediator.NAME);
			editor.registerMediator(popUp, 					PopUpMediator.NAME);
			
			registerEvents();
			
			owner.main.enabled = false;
			
		}
		
		private function initMenuBar():void
		{
			var data:XMLList 						= this.menuData[PlanEditMode.mode];
			owner.menuBar.dataProvider 	= new XMLListCollection(data);
			owner.menuBar.addEventListener(MenuEvent.ITEM_CLICK, menuClickHandler);
			var orientation:XMLList 				= data..menu.(@id == 'orientation');
			orientation.menu 				 		+=new XML('<item label="' + PlanOrientationDefinition.A4Album.label 	+ '" id="' + PlanOrientationDefinition.A4Album.id	+	'" toggled="true" type="radio"/>');
			orientation.menu 				 		+=new XML('<item label="' + PlanOrientationDefinition.A4Portrait.label 	+ '" id="' + PlanOrientationDefinition.A4Portrait.id+	'" toggled="false" type="radio"/>');
			//var t:* = 	data..item.(@id=="copy from");
			//t.@enabled = "true";
		}
		
		private function menuClickHandler(event:MenuEvent):void
		{
			var id:String = event.item.@id;
			switch( id )
			{
				
				case "open":
					
					sendNotification(NAMES.SERIALIZE_COMMAND);
					if( planData.equal( currentPlanData ) || PlanEditMode.isReadOnlyMode )
						sendNotification(NAMES.OPEN_READ_DIALOG);
					else
					{
						Alert.show("Сохранить план?", "Предупреждение", Alert.YES | Alert.NO | Alert.CANCEL, owner, 
							function (event:CloseEvent):void
							{
								if( event.detail == Alert.NO )
									sendNotification(NAMES.OPEN_READ_DIALOG);
								else if( event.detail == Alert.YES )
								{
									sendNotification(NAMES.DATA_SAVE_PLAN);
									needOpenAfterSave = true;
								}
							}
						);
					}
					
					break;
				
				case "save":
					
					sendNotification(NAMES.SERIALIZE_COMMAND);
					//if( !planData.equal( currentPlanData ) )
					sendNotification(NAMES.DATA_SAVE_PLAN);
					
					break;
				
				case "save as":
					
					sendNotification(NAMES.SERIALIZE_COMMAND);
					sendNotification(NAMES.OPEN_SAVE_DIALOG);
					
					break;
				
				case "copy from":
					
					if( editor.model.pagesData.elements.length == 0 )
						sendNotification(NAMES.OPEN_COPY_DIALOG);
					else
						Alert.show("План должен быть пустым", "Предупреждение"); 
					
					break;
				
				case PlanOrientationDefinition.A4Album.id:
					
					sendNotification(NAMES.SET_PLAN_ORIENTATION, currentPlanData.orientation = PlanOrientationDefinition.A4Album);
					sendNotification(NAMES.SERIALIZE_HEAD_COMMAND, currentPlanData.getData());
					
					break;
				
				case PlanOrientationDefinition.A4Portrait.id:
					
					sendNotification(NAMES.SET_PLAN_ORIENTATION, currentPlanData.orientation = PlanOrientationDefinition.A4Portrait);
					sendNotification(NAMES.SERIALIZE_HEAD_COMMAND, currentPlanData.getData());
					
					break;
				
				default:
					
					break;
				
			}
		}
	} 
}