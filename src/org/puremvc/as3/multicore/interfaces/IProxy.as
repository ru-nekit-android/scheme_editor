package org.puremvc.as3.multicore.interfaces
{
	
	public interface IProxy extends INotifier
	{
		
		function getProxyName():String;
		function setData( data:Object ):void;
		function getData():Object; 
		function onRegister( ):void;
		function onRemove( ):void;
		
	}
}