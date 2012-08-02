package org.puremvc.as3.multicore.interfaces
{
	
	public interface IObserver
	{

		function set notifyMethod( notifyMethod:Function ):void;
		function set notifyContext( notifyContext:Object ):void;
		function notifyObserver( notification:INotification ):void;
		function compareNotifyContext( object:Object ):Boolean;
		
	}
}