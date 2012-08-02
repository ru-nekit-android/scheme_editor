package org.puremvc.as3.multicore.interfaces
{
	
	public interface IView 
	{

		function registerObserver( notificationName:String, observer:IObserver ) : void;
		function removeObserver( notificationName:String, notifyContext:Object ):void;
		function notifyObservers( note:INotification ) : void;
		function registerMediator(mediator:IMediator, mediatorName:String ):IMediator;
		function retrieveMediator( mediatorName:String ) : IMediator;
		function removeMediator( mediatorName:String ) : IMediator;
		function hasMediator( mediatorName:String ) : Boolean;

	}
}