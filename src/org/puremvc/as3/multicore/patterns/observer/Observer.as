package org.puremvc.as3.multicore.patterns.observer
{
	import org.puremvc.as3.multicore.interfaces.*;

	public class Observer implements IObserver
	{
		private var notify:Function;
		private var context:Object;
	
		public function Observer( notifyMethod:Function, notifyContext:Object ) 
		{
			this.notifyMethod = notifyMethod;
			this.notifyContext = notifyContext;
		}
		
		public function set notifyMethod( notifyMethod:Function ):void
		{
			notify = notifyMethod;
		}
		
		public function set notifyContext( notifyContext:Object ):void
		{
			context = notifyContext;
		}
		
		public function get notifyMethod():Function
		{
			return notify;
		}
		
		public function get notifyContext():Object
		{
			return context;
		}
		
		public function notifyObserver( notification:INotification ):void
		{
			this.notifyMethod.apply(this.notifyContext,[notification]);
		}
	
		 public function compareNotifyContext( object:Object ):Boolean
		 {
		 	return object === this.context;
		 }		
	}
}