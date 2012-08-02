package ru.nekit.planEditor.model.action
{
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class MouseAction
	{
		
		public static const PREACTIVE:String 		= "preactive";
		public static const ACTIVE:String 				= "active";
		public static const SELECT_OBJECT:String 	= "object_move";
		
		private const position:Point 					= new Point;
		private const positionStart:Point 			= new Point;
		
		public var event:MouseEvent;
		public var selectionStatus:String;
		
		public function get selectionBounds():Rectangle
		{
			return new Rectangle( Math.min( positionStart.x, position.x ), Math.min(positionStart.y, position.y ), Math.abs( positionStart.x - position.x ), Math.abs( positionStart.y - position.y ));
		}
		
		public function get x():Number
		{
			return position.x;
		}
		
		public function get y():Number
		{
			return position.y;
		}
		
		public function set x(value:Number):void
		{
			if( x != value )
				position.x = value;
		}
		
		public function set y(value:Number):void
		{
			if( y != value )
				position.y = value;
		}
		
		public function get startX():Number
		{
			return positionStart.x;
		}
		
		public function get startY():Number
		{
			return positionStart.y;
		}
		
		public function set startX(value:Number):void
		{
			if( startX != value )
				positionStart.x = value;
		}
		
		public function set startY(value:Number):void
		{
			if( startY != value )
				positionStart.y = value;
		}
	}
}