package org.puremvc.as3.multicore.interfaces
{
	
	public interface INotification
	{
		
		function get name():String;
		function set body( body:Object ):void;
		function get body():Object;
		function set type( type:String ):void;
		function get type():String;
		function toString():String;
	}
}