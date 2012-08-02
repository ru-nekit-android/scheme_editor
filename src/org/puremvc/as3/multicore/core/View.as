package org.puremvc.as3.multicore.core
{

	import flash.events.IEventDispatcher;
	
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.observer.*;

	public class View implements IView
	{
		
		public function View( key:String )
		{
			if (instanceMap[ key ] != null) throw Error(MULTITON_MSG);
			multitonKey = key;
			instanceMap[ multitonKey ] = this;
			mediatorMap = new Array();
			observerMap = new Array();	
			initializeView();	
		}
	
		protected function initializeView(  ) : void 
		{
		}
	
		public static function getInstance( key:String ) : IView 
		{
			if ( instanceMap[ key ] == null ) instanceMap[ key ] = new View( key );
			return instanceMap[ key ];
		}
	
		public function registerObserver ( notificationName:String, observer:IObserver ) : void
		{
			if( observerMap[ notificationName ] != null ) {
				observerMap[ notificationName ].push( observer );
			} else {
				observerMap[ notificationName ] = [ observer ];	
			}
		}

		public function notifyObservers( notification:INotification ) : void
		{
			if( observerMap[ notification.name ] != null ) {
				
				var observers_ref:Array = observerMap[ notification.name ] as Array;
   				var observers:Array = new Array(); 
   				var observer:IObserver;
				for (var i:Number = 0; i < observers_ref.length; i++) { 
					observer = observers_ref[ i ] as IObserver;
					observers.push( observer );
				}
				for (i = 0; i < observers.length; i++) {
					observer = observers[ i ] as IObserver;
					observer.notifyObserver( notification );
				}
			}
		}
						

		public function removeObserver( notificationName:String, notifyContext:Object ):void
		{
			var observers:Array = observerMap[ notificationName ] as Array;
			for ( var i:int=0; i<observers.length; i++ ) 
			{
				if ( Observer(observers[i]).compareNotifyContext( notifyContext ) == true ) {
					observers.splice(i,1);
					break;
				}
			}
			if ( observers.length == 0 ) {
				delete observerMap[ notificationName ];		
			}
		} 

		public function registerMediator( mediator:IMediator, mediatorName:String) : IMediator
		{
			if ( mediatorMap[mediatorName] != null ) return null;
			mediatorMap[mediatorName] = mediator;
			var interests:Array = mediator.listNotificationInterests();
			if ( interests.length > 0 ) 
			{
				var observer:Observer = new Observer( mediator.handleNotification, mediator );
				for ( var i:Number=0;  i<interests.length; i++ ) 
				{
					registerObserver( interests[i],  observer );
				}			
			}
			interests = mediator.listEventInterests();
			if ( interests.length > 0 ) 
			{
				for ( i = 0;  i<interests.length; i++ ) 
				{
					IEventDispatcher(mediator.viewComponent).addEventListener(interests[i], mediator.handleEvent);
				}
			}
			mediator.onRegister();
			return mediator;
		}

		public function retrieveMediator( mediatorName:String ) : IMediator
		{
			return mediatorMap[ mediatorName ];
		}

		public function removeMediator( mediatorName:String ) : IMediator
		{
		
			var mediator:IMediator = mediatorMap[ mediatorName ] as IMediator;
			if ( mediator ) 
			{
				var interests:Array = mediator.listNotificationInterests();
				for ( var i:Number=0; i<interests.length; i++ ) 
				{
					removeObserver( interests[i], mediator );
				}	
				delete mediatorMap[ mediatorName ];
				mediator.onRemove();
			}
			return mediator;
		}
						
		public function hasMediator( mediatorName:String ) : Boolean
		{
			return mediatorMap[ mediatorName ] != null;
		}
		
		public static function removeView( key:String ):void
		{
			delete instanceMap[ key ];
		}
		
		protected var mediatorMap : Array;
		protected var observerMap	: Array;
		protected static var instanceMap : Array = new Array();
		protected var multitonKey : String;
		protected const MULTITON_MSG:String = "View instance for this Multiton key already constructed!";
	}
}