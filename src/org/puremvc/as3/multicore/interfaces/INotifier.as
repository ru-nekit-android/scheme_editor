package org.puremvc.as3.multicore.interfaces
{
	
	public interface INotifier
	{
		
		function sendNotification( notificationName:String, body:Object=null, type:String=null ):void; 
		function initializeNotifier( key:String ): void;
		
	}
}