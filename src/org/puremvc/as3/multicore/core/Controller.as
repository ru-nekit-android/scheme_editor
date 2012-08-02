package org.puremvc.as3.multicore.core
{
	import flash.errors.IllegalOperationError;
	
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.observer.*;
	
	public class Controller implements IController
	{
		
		public function Controller( key:String )
		{
			if (instanceMap[ key ] != null) throw IllegalOperationError(MULTITON_MSG);
			multitonKey = key;
			instanceMap[ multitonKey ] = this;
			commandMap = new Array();	
			initializeController();	
		}
		
		protected function initializeController(  ) : void 
		{
			view = View.getInstance( multitonKey );
		}
	
		public static function getInstance( key:String ) : IController
		{
			if ( instanceMap[ key ] == null ) instanceMap[ key ] = new Controller( key );
			return instanceMap[ key ];
		}

		public function executeCommand( note : INotification ) : void
		{
			var commandClassRef : Class = commandMap[ note.name ];
			if ( commandClassRef == null ) return;

			var commandInstance : ICommand = new commandClassRef();
			commandInstance.initializeNotifier( multitonKey );
			commandInstance.execute( note );
		}

		public function registerCommand( notificationName : String, commandClassRef : Class ) : void
		{
			if ( commandMap[ notificationName ] == null ) {
				view.registerObserver( notificationName, new Observer( executeCommand, this ) );
			}
			commandMap[ notificationName ] = commandClassRef;
		}
		
		public function hasCommand( notificationName:String ) : Boolean
		{
			return commandMap[ notificationName ] != null;
		}

		public function removeCommand( notificationName : String ) : void
		{
			if ( hasCommand( notificationName ) )
			{
				view.removeObserver( notificationName, this );
				commandMap[ notificationName ] = null;
			}
		}
		
		public static function removeController( key:String ):void
		{
			delete instanceMap[ key ];
		}
		
		protected var view : IView;
		protected var commandMap : Array;
		protected var multitonKey : String;
		protected static var instanceMap : Array = new Array();
		protected const MULTITON_MSG : String = "Controller instance for this Multiton key already constructed!";

	}
}