package org.puremvc.as3.multicore.patterns.observer
{
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	import ru.nekit.planEditor.PlanEditor;
	
	public class Notifier extends EventDispatcher implements INotifier
	{
		
		public function sendNotification( notificationName:String, body:Object=null, type:String=null ):void 
		{
			if (facade != null) 
				facade.sendNotification( notificationName, body, type );
		}
		
		public function initializeNotifier( key:String ):void
		{
			multitonKey = key;
		}
		
		protected function get facade():IFacade
		{
			if ( multitonKey == null ) throw IllegalOperationError( MULTITON_MSG );
			return Facade.getInstance( multitonKey );
		}
		
		public const editor:PlanEditor = PlanEditor.instance;
	
		protected var multitonKey : String;
		protected const MULTITON_MSG : String = "multitonKey for this Notifier not yet initialized!";

	}
}