package org.puremvc.as3.multicore.patterns.observer
{
	import org.puremvc.as3.multicore.interfaces.*;
	
	public class Notification implements INotification
	{
		
		/**
		 * Constructor. 
		 * 
		 * @param name name of the <code>Notification</code> instance. (required)
		 * @param body the <code>Notification</code> body. (optional)
		 * @param type the type of the <code>Notification</code> (optional)
		 */
		public function Notification( name:String, body:Object=null, type:String=null )
		{
			this._name = name;
			this._body = body;
			this._type = type;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set body( body:Object ):void
		{
			this._body = body;
		}
		
		public function get body():Object
		{
			return _body;
		}
	
		public function set type( type:String ):void
		{
			this._type = type;
		}
		
		public function get type():String
		{
			return _type;
		}

		public function toString():String
		{
			var msg:String = "Notification Name: "+name;
			msg += "\nBody:"+(( body == null )?"null":body.toString());
			msg += "\nType:"+(( type == null )?"null":type);
			return msg;
		}
		
		private var _name			: String;
		private var _type			: String;
		private var _body			: Object;
		
	}
}