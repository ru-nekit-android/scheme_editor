package ru.nekit.planEditor.model.planElement
{
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	
	public class StairwellElement extends BaseElement
	{
		
		public function StairwellElement()
		{
			super();
			_fill					= _fillDefault			= 0xcccccc;
			_stroke			= _strokeDefault 	= 0x000000;
			explicitWidth 	= 40;
			explicitHeight 	= 20;
		}
		
		override public function registerOnLayer():void
		{
			if( !_registered )
			{
				draw();
				_registered = true;
			}
		}
		
		override public function unregisterOnLayer():void
		{
			_registered = false;
		}
		
		override public function copy():BaseElement
		{
			var result:StairwellElement = new StairwellElement;
			result.explicitHeight 	= explicitHeight;
			result.explicitWidth 		= explicitWidth;
			result.x           				= x;
			result.y           				= y;
			result.layer     				= layer;
			result._stroke				= _stroke;
			result._fill						= _fill;
			result._fillDefault			= _fillDefault;
			result._strokeDefault 	= _strokeDefault;
			return result;
		}
		
		override protected function draw():void
		{
			graphics.clear();
			graphics.lineStyle(1, _stroke, _backgroundVisible ? 1 : .1);//, false, LineScaleMode.VERTICAL, CapsStyle.NONE, JointStyle.MITER, 10);
			graphics.beginFill(_fill, _backgroundVisible ? 1 : .1);
			graphics.drawRect (0, 0, width, height);
			graphics.endFill();	
		}
	}
}