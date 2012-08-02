package org.puremvc.as3.multicore.patterns.facade
{
	import flash.errors.IllegalOperationError;
	
	import org.puremvc.as3.multicore.core.*;
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.observer.*;

	public class Facade implements IFacade
	{
		
		public function Facade( key:String )
		{
			if (instanceMap[ key ] != null) throw IllegalOperationError(MULTITON_MSG);
			initializeNotifier( key );
			instanceMap[ multitonKey ] = this;
			initializeFacade();	
		}
		
		protected function initializeFacade(  ):void
		{
			initializeModel();
			initializeController();
			initializeView();
		}

		public static function getInstance( key:String ):IFacade
		{
			if (instanceMap[ key ] == null ) instanceMap[ key ] = new Facade( key );
			return instanceMap[ key ];
		}

		protected function initializeController( ):void
		{
			if ( controllerCore != null ) return;
			controllerCore = Controller.getInstance( multitonKey );
		}

		protected function initializeModel( ):void
		{
			if ( modelCore != null ) return;
			modelCore = Model.getInstance( multitonKey );
		}
		
		protected function initializeView( ):void 
		{
			if ( viewCore != null ) return;
			viewCore = View.getInstance( multitonKey );
		}
		
		public function registerCommand( notificationName:String, commandClassRef:Class ):void 
		{
			controllerCore.registerCommand( notificationName, commandClassRef );
		}

		public function removeCommand( notificationName:String ):void 
		{
			controllerCore.removeCommand( notificationName );
		}

		public function hasCommand( notificationName:String ) : Boolean
		{
			return controllerCore.hasCommand(notificationName);
		}

		public function registerProxy ( proxy:IProxy ):void	
		{
			modelCore.registerProxy ( proxy );	
		}
		
		public function retrieveProxy ( proxyName:String ):IProxy 
		{
			return modelCore.retrieveProxy ( proxyName );	
		}

		public function removeProxy ( proxyName:String ):IProxy 
		{
			var proxy:IProxy;
			if ( modelCore != null ) proxy = modelCore.removeProxy ( proxyName );	
			return proxy
		}

		public function hasProxy( proxyName:String ) : Boolean
		{
			return modelCore.hasProxy( proxyName );
		}

		public function registerMediator(mediator:IMediator, mediatorName:String ):IMediator
		{
			if ( viewCore != null ) return viewCore.registerMediator( mediator, mediatorName );
			return null;
		}

		public function retrieveMediator( mediatorName:String ):IMediator 
		{
			return viewCore.retrieveMediator( mediatorName ) as IMediator;
		}

		public function removeMediator( mediatorName:String ) : IMediator 
		{
			var mediator:IMediator;
			if ( viewCore != null ) mediator = viewCore.removeMediator( mediatorName );			
			return mediator;
		}

		public function hasMediator( mediatorName:String ) : Boolean
		{
			return viewCore.hasMediator( mediatorName );
		}

		public function sendNotification( notificationName:String, body:Object=null, type:String=null ):void 
		{
			notifyObservers( new Notification( notificationName, body, type ) );
		}

		public function notifyObservers ( notification:INotification ):void {
			if ( viewCore != null ) viewCore.notifyObservers( notification );
		}

		public function initializeNotifier( key:String ):void
		{
			multitonKey = key;
		}

		public static function hasCore( key:String ) : Boolean
		{
			return ( instanceMap[ key ] != null );
		}

		public static function removeCore( key:String ) : void
		{
			if (instanceMap[ key ] == null) return;
			Model.removeModel( key ); 
			View.removeView( key );
			Controller.removeController( key );
			delete instanceMap[ key ];
		}

		protected var controllerCore : IController;
		protected var modelCore		 : IModel;
		protected var viewCore		 : IView;
		protected var multitonKey : String;
		protected static var instanceMap : Array = new Array(); 
		protected const MULTITON_MSG:String = "Facade instance for this Multiton key already constructed!";
	
	}
}