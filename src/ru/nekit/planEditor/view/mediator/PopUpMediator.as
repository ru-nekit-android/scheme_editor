package ru.nekit.planEditor.view.mediator
{
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import ru.nekit.planEditor.NAMES;
	import ru.nekit.planEditor.PlanEditor;
	import ru.nekit.planEditor.model.dataModel.*;
	import ru.nekit.planEditor.model.vo.*;
	import ru.nekit.planEditor.view.frame.PopUpFrame;
	import spark.events.DropDownEvent;
	import spark.events.IndexChangeEvent;
	import spark.events.TextOperationEvent;
	
	public class PopUpMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "PopUpMediator";
		
		private static var _popUp:PopUpFrame;
		private static const address:AddressDataItem = new AddressDataItem;
		
		public function PopUpMediator()
		{
			super(null);
			initializeNotifier(PlanEditor.KEY);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				NAMES.CLOSE_DIALOG,
				NAMES.OPEN_READ_DIALOG,
				NAMES.OPEN_SAVE_DIALOG,
				NAMES.OPEN_COPY_DIALOG,
				NAMES.DATA_READ_STREETS_SUCCESS,
				NAMES.DATA_SAVE_PLAN_SUCCESS,
				NAMES.DATA_READ_PLAN_SUCCESS,
				NAMES.DATA_READ_BUILDINGS_SUCCESS,
			]
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var body:Object = notification.body;
			
			switch( notification.name )
			{
				
				case NAMES.OPEN_READ_DIALOG:
					
					createPopUp("open");
					owner.cancelBtn.visible = owner.cancelBtn.includeInLayout = !( notification.body );
					
					break;
				
				case NAMES.OPEN_SAVE_DIALOG:
					
					createPopUp("save");
					
					break;
				
				case NAMES.OPEN_COPY_DIALOG:
					
					createPopUp("copy");
					
					break;
				
				case NAMES.DATA_READ_BUILDINGS_SUCCESS:
					
					if( address.street && address.street.id != 0 )
					{
						var buildingList:BuildingList = new BuildingList;
						buildingList.setData(body);
						_popUp.buildingList.dataProvider = buildingList.dataProvider;
					}
					
					break;
				
				case NAMES.CLOSE_DIALOG:
				case NAMES.DATA_SAVE_PLAN_SUCCESS:
				case NAMES.DATA_READ_PLAN_SUCCESS:
					
					destroyPopUp();
					
					break;
				
				case NAMES.DATA_READ_STREETS_SUCCESS:
					
					if(_popUp && !_popUp.streetList.dataProvider )
						_popUp.streetList.dataProvider 	= editor.model.streetList.dataProvider;
					
					break;
				
				default:
					break;
				
			}
		}
		
		override public function get currentState():String
		{
			return _popUp.currentState;
		}
		
		private function createPopUp(state:String):void
		{
			if( !_popUp )
			{
				_popUp = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject, PopUpFrame, true) as PopUpFrame;
				PopUpManager.centerPopUp(_popUp);
				_popUp.currentState 					= state;
				_popUp.streetList.dataProvider 	= editor.model.streetList.dataProvider;
				_popUp[currentState].enabled = false;
				if( currentState == "open" )
					_popUp.title = "Открытие плана"
				else	 if( currentState == "save" )
					_popUp.title = "Сохранение плана"
				else if( currentState == "copy" )
					_popUp.title = "Копирование плана"
				registerEvents();
			}
		}
		
		private function destroyPopUp():void
		{
			if( _popUp )
			{
				with( _popUp )
				{
					removeEventListener(Event.CANCEL, cancelHandler);
					streetList.textInput.removeEventListener(TextOperationEvent.CHANGE, 	streetTextChangeHandler);	
					streetList.removeEventListener(DropDownEvent.CLOSE, 							streetChoiceHandler);
					buildingList.removeEventListener(IndexChangeEvent.CHANGE, 					buildingChoiceHandler);
					removeEventListener(Event.CANCEL, cancelHandler);
					if( currentState == "open" )
						open.removeEventListener(MouseEvent.CLICK, openClickHandler);
					else if( currentState == "save" )
						save.removeEventListener(MouseEvent.CLICK, saveClickHandler);
					else if( currentState == "copy" )
						copy.removeEventListener(MouseEvent.CLICK, copyClickHandler);
				}
				address.clear();
				PopUpManager.removePopUp(_popUp);
				_popUp = null;
			}
		}
		
		private function streetTextChangeHandler(event:TextOperationEvent):void
		{
			var source:Array 	= ArrayCollection(_popUp.streetList.dataProvider).source;
			var result:Array 		= new Array;
			const length:uint 	= source.length;
			for( var i:uint = 0; i < length; i++)
			{
				var name:String = StreetVO(source[i]).name;
				if( _popUp.streetList.textInput.text != "" && name.toLowerCase().indexOf(  _popUp.streetList.textInput.text.toLowerCase() ) != -1 )
					result.push(source[i]);
			}
			if( result.length == 0 )
				_popUp.streetList.dataProvider = editor.model.streetList.dataProvider;
			else
				_popUp.streetList.dataProvider = new ArrayCollection(result);
		}
		
		private function streetChoiceHandler(event:DropDownEvent):void
		{
			var street:StreetVO = _popUp.streetList.selectedItem as StreetVO;
			if( street && address.street.id != street.id )
			{
				address.street.set(street);
				_popUp[currentState].enabled = false;
				sendNotification(NAMES.DATA_COMMAND, address.street.id, NAMES.DATA_READ_BUILDINGS);
			}
		}
		
		private function buildingChoiceHandler(event:IndexChangeEvent):void
		{
			var building:BuildingVO = _popUp.buildingList.selectedItem as BuildingVO;
			if( building )
			{
				address.building.set(building);
				_popUp[currentState].enabled = true;
			}
		}
		
		private function saveClickHandler(event:MouseEvent):void
		{
			_popUp.enabled = false;
			sendNotification(NAMES.SET_ADDRESS, address);
			sendNotification(NAMES.DATA_SAVE_PLAN);
		}
		
		private function copyClickHandler(event:MouseEvent):void
		{
			_popUp.enabled = false;
			sendNotification(NAMES.DATA_READ_PLAN, address);
		}
		
		private function openClickHandler(event:MouseEvent):void
		{
			_popUp.enabled = false;
			sendNotification(NAMES.OPEN_READ_DIALOG_OK);
			sendNotification(NAMES.SET_ADDRESS, address);
			sendNotification(NAMES.DATA_READ_PLAN, address);
		}
		
		private function registerEvents():void
		{
			with( _popUp )
			{
				addEventListener(Event.CANCEL, cancelHandler);
				streetList.textInput.addEventListener(TextOperationEvent.CHANGE, streetTextChangeHandler);	
				streetList.addEventListener(DropDownEvent.CLOSE, 							streetChoiceHandler);
				buildingList.addEventListener(IndexChangeEvent.CHANGE, 				buildingChoiceHandler);
				if( currentState == "open" )
					open.addEventListener(MouseEvent.CLICK, openClickHandler);
				else if( currentState == "save" )
					save.addEventListener(MouseEvent.CLICK, saveClickHandler);
				else if( currentState == "copy" )
					copy.addEventListener(MouseEvent.CLICK, copyClickHandler);
			}
		}
		
		private function cancelHandler(event:Event):void
		{
			destroyPopUp();
		}
		
		public function get owner():PopUpFrame
		{
			return _popUp;
		}
	}
}