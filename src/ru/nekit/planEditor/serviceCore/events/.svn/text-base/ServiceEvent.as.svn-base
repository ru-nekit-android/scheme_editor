package ru.nekit.planEditor.serviceCore.events{
	
	import flash.events.Event;
	
	import ru.nekit.planEditor.serviceCore.serviceUtil.result.ServiceUtilResult;
	
	public class ServiceEvent extends Event{
		
		public static const SUCCESS:String  		= "success";
		public static const FAILED:String   		= "failed";	
		public static const START:String    		= "start";
		public static const PROGRESS:String 	= "progress";
		public static const PAUSE:String    		= "pause";
		public static const UPDATE:String    		= "update";
		
		public var result:ServiceUtilResult;
		
		public function ServiceEvent(type:String, result:ServiceUtilResult, bubbles:Boolean=false, cancelable:Boolean=true){
			super(type, bubbles, cancelable);
			this.result 			= result;
		}
	}
}