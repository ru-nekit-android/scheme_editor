package org.puremvc.as3.multicore.interfaces
{

	public interface IFacade extends INotifier
	{

		function registerProxy( proxy:IProxy ) : void;
		function retrieveProxy( proxyName:String ) : IProxy;
		function removeProxy( proxyName:String ) : IProxy;
		function hasProxy( proxyName:String ) : Boolean;
		function registerCommand( noteName : String, commandClassRef : Class ) : void;
		function removeCommand( notificationName:String ): void;
		function hasCommand( notificationName:String ) : Boolean;
		function registerMediator(mediator:IMediator, mediatorName:String ):IMediator;
		function retrieveMediator( mediatorName:String ) : IMediator;
		function removeMediator( mediatorName:String ) : IMediator;
		function hasMediator( mediatorName:String ) : Boolean;
		function notifyObservers( notification:INotification ):void;

	}
}