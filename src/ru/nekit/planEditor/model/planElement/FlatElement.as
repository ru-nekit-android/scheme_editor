package ru.nekit.planEditor.model.planElement
{
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.events.KeyboardEvent;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	public class FlatElement extends LabelElement
	{
		
		public function FlatElement()
		{
			super();
			toolTip 						= "Двойное нажатие мыши для редактирования номера квартиры";
			_fill 							= _fillDefault 			= 0xffffff;
			_stroke		 			= _strokeDefault 	= 0xff0000;
			_color						= _colorDefault		= 0x00ff00;
			explicitWidth 			= 25;
			explicitHeight 			= 20;
			setMinWidth(25);
			setMinHeight(20);
			_label.multiline 		= false;
		}
		
		override protected function draw():void
		{
			graphics.clear();	
			graphics.lineStyle(1, _stroke, _backgroundVisible ? 1 : .1);//, false, LineScaleMode.VERTICAL, CapsStyle.NONE, JointStyle.MITER, 10);
			graphics.beginFill(_fill, _backgroundVisible ? 1 : .1);
			graphics.drawRect (0, 0, width, height);
			graphics.endFill();	
		}
		
		override public function get labelTextFormat():TextFormat
		{
			return _labelTextFormat;
		}
		
		override public function copy():BaseElement
		{
			var result:FlatElement 			= new FlatElement;
			result.explicitHeight 				= explicitHeight;
			result.explicitWidth 					= explicitWidth;
			result.x           							= x;
			result.y           							= y;
			result.layer     							= layer;
			result._label.text    					= label;
			result._labelTextFormat.align = textAlign;
			result.fontSize							=	 _fontSize;
			result._stroke							= _stroke;
			result._fill									= _fill;
			result.color								= _color;
			result.bold								= _bold;
			result.underline						= _underline;
			result.italic								= _italic;
			result._fontSizeDefault			= _fontSizeDefault;
			result._strokeDefault 				= _strokeDefault;
			result._colorDefault					= _colorDefault;
			result._boldDefault					= _boldDefault;
			result._italicDefault					= _italicDefault;
			result._underlineDefault			= _underlineDefault;
			return result;
		}
		
		private function keyHandler(event:KeyboardEvent):void
		{
			if( event.keyCode == Keyboard.ENTER)
				drawLabel();
		}	
		
		override public function registerOnLayer():void
		{
			if( !_registered )
				_label.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			super.registerOnLayer();
		}
		
		override public function unregisterOnLayer():void
		{
			if( _registered )
				_label.removeEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			super.unregisterOnLayer();
		}
	}
}