/*
 PureMVC MultiCore - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by the Creative Commons Attribution 3.0 United States License
*/
package org.puremvc.as3.multicore.core
{
	
	import org.puremvc.as3.multicore.interfaces.*;
	
	public class Model implements IModel
	{
	
		public function Model( key:String )
		{
			if (instanceMap[ key ] != null) throw Error(MULTITON_MSG);
			multitonKey = key;
			instanceMap[ multitonKey ] = this;
			proxyMap = new Array();	
			initializeModel();	
		}

		protected function initializeModel(  ) : void 
		{
		}
		
		public static function getInstance( key:String ) : IModel 
		{
			if (instanceMap[ key ] == null) instanceMap[key] = new Model( key );
			return instanceMap[key];
		}

		public function registerProxy( proxy:IProxy ) : void
		{
			proxy.initializeNotifier( multitonKey );
			proxyMap[ proxy.getProxyName() ] = proxy;
			proxy.onRegister();
		}

		public function retrieveProxy( proxyName:String ) : IProxy
		{
			return proxyMap[ proxyName ];
		}

		public function hasProxy( proxyName:String ) : Boolean
		{
			return proxyMap[ proxyName ] != null;
		}

		public function removeProxy( proxyName:String ) : IProxy
		{
			var proxy:IProxy = proxyMap [ proxyName ] as IProxy;
			if ( proxy ) 
			{
				proxyMap[ proxyName ] = null;
				proxy.onRemove();
			}
			return proxy;
		}

		public static function removeModel( key:String ):void
		{
			delete instanceMap[ key ];
		}

		protected var proxyMap : Array;

		protected static var instanceMap:Array = new Array();
		
		protected var multitonKey : String;

		protected const MULTITON_MSG:String = "Model instance for this Multiton key already constructed!";

	}

}