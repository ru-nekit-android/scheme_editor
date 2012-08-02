package ru.nekit.planEditor.model.action
{
	import flash.events.KeyboardEvent;

	public class KeyAction
	{
		
		public var event:KeyboardEvent;
		
		public function get keyCode():int
		{
			return event ? event.keyCode : -1;
		}
		
		public function get ctrlKey():Boolean
		{
			return event ? event.ctrlKey : false;
		}
		
		public function get shiftKey():Boolean
		{
			return event ? event.shiftKey : false;
		}
		
		public function get altKey():Boolean
		{
			return event ? event.altKey : false;
		}
		
	}
}