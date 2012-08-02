package ru.nekit.planEditor.util
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import mx.core.IVisualElement;
	
	import spark.components.Group;
	
	public final class Util
	{
		public static function rectangle(value:DisplayObject):Rectangle
		{
			return new Rectangle(value.x, value.y, value.width, value.height);
		}
		
		public static function isIntersect(value:Rectangle, value2:Rectangle):Boolean
		{
			return value.intersects(value2);
		}
		
		public static function roundTo(value:Number, to:Number):Number 
		{
			return Math.round(value / to) * to;
		}
		
		public static function floorTo(value:Number, to:Number):Number 
		{
			return Math.floor(value / to) * to;
		}
		
		public static function correctInColor(value:String):String
		{
			value 					= value.indexOf("0x") == 0 ? value.substring(2) : value;
			var length:uint 	= 6 - value.length;
			var add:String 	= "";
			for( var i:uint = 0; i < length; i++)
				add += "0";
			return add + value;
		}
		
		public static function correctOutColor(value:String):uint
		{
			return  uint( "0x"+ value );
		}
		
		public static function setOnTop(element:DisplayObject):void 
		{
			var highest_depth:int = element.parent.numChildren - 1;
			var current_depth:int = element.parent.getChildIndex(element);
			if ( current_depth < highest_depth)
			{
				if( element.parent is Group)
					Group(element.parent).setElementIndex(IVisualElement(element), highest_depth);
				else
					element.parent.setChildIndex(element, highest_depth);
			}
		}		
	}
}