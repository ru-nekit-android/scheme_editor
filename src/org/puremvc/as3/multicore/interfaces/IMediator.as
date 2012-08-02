package org.puremvc.as3.multicore.interfaces
{
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	public interface IMediator extends INotifier
	{
		
		function get viewComponent():IEventDispatcher;
		function listNotificationInterests():Array;
		function listEventInterests():Array;
		function handleNotification( notification:INotification ):void;
		function handleEvent( event:Event ):void;
		function onRegister( ):void;
		function onRemove( ):void;
		
	}
}