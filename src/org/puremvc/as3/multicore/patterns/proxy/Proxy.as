package org.puremvc.as3.multicore.patterns.proxy
{
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.interfaces.INotifier;
	import org.puremvc.as3.multicore.patterns.observer.Notifier;
	
	public class Proxy extends Notifier implements IProxy, INotifier
	{

		public static var NAME:String = 'Proxy';
		
		public function Proxy( proxyName:String=null, data:Object=null ) 
		{
			this.proxyName = (proxyName != null)?proxyName:NAME; 
			if (data != null) setData(data);
		}

		public function getProxyName():String 
		{
			return proxyName;
		}		
		
		public function setData( data:Object ):void 
		{
			this.data = data;
		}
		
		public function getData():Object 
		{
			return data;
		}		
		
		public function onRegister( ):void {}

		public function onRemove( ):void {}
	
		protected var proxyName:String;
		protected var data:Object;
	}
}