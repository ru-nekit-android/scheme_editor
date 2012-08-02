package org.puremvc.as3.multicore.patterns.mediator
{
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.core.UIComponent;
	
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.observer.Notifier;
	
	public class Mediator extends Notifier implements IMediator, INotifier
	{

		public static const NAME:String = 'Mediator';
		
		public function Mediator( viewComponent:UIComponent ) 
		{
			_viewComponent = viewComponent;	
		}
		
		public function listNotificationInterests():Array 
		{
			return [ ];
		}
		
		public function listEventInterests():Array
		{
			return [ ];
		}
		
		public function get viewComponent():IEventDispatcher
		{
			return _viewComponent;
		}
		
		public function handleNotification( notification:INotification ):void {};
		public function handleEvent( event:Event ):void {};
		public function onRegister( ):void {};
		public function onRemove( ):void {};
		
		public function set currentState(name:String):void{
			if( name != currentState ){
				_viewComponent.currentState = name;	
			}
		}
		
		public function get currentState():String{
			return _viewComponent.currentState;	
		}
		
		protected var _viewComponent:UIComponent;
		
	}
}