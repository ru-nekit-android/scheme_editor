package ru.nekit.planEditor.model.planElement
{
	
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import mx.collections.ArrayCollection;
	
	final public class SplitterElement extends AttenuatorElement
	{
		
		public function SplitterElement()
		{
			toolTip = "";
			explicitWidth 						= 25;
			explicitHeight 						= 15;
			setMinWidth(25);
			setMinHeight(15);
			_fill										= _fillDefault 			= 0xccffcc;
			_stroke								= _strokeDefault 	= 0x009900;
			_fontSize								= _fontSizeDefault	= 13;
			_color									= _colorDefault		= 0x000000;
			_labelTextFormat				= new TextFormat("Tahoma", _fontSize, _color,  null, null, null, null, null, TextFormatAlign.CENTER );
			_label.multiline 					= false;
			_label.mouseEnabled 			= false
			_label.autoSize 					= TextFieldAutoSize.CENTER;
		}
		
		override public function get paramDataProvider():ArrayCollection
		{
			return new ArrayCollection([204, 306, 408]);
		}
		
		override protected function updateLabel():void
		{
			_label.text = "S" + ( _param > 0 ? _param  : "_" );
		}
		
		override public function copy():BaseElement
		{
			var result:SplitterElement 		= new SplitterElement;
			result.explicitHeight 				= explicitHeight;
			result.explicitWidth 					= explicitWidth;
			result._param							= _param;
			result.x           							= x;
			result.y           							= y;
			result.layer     							= layer;
			result._label.text		    			= _label.text;
			result.textAlign 						= textAlign;
			result._stroke							= _stroke;
			result._fill									= _fill;
			result._fillDefault						= _fillDefault;
			result._strokeDefault 				= _strokeDefault;
			
			result.textAlign						= _textAlign;
			result.fontSize							= _fontSize;
			result.color								= _color;
			result.bold								= _bold;
			result.underline						= _underline;
			result.italic								= _italic;
			result._fontSizeDefault			= _fontSizeDefault;
			result._colorDefault					= _colorDefault;
			result._boldDefault					= _boldDefault;
			result._italicDefault					= _italicDefault;
			result._underlineDefault			= _underlineDefault;
			return result;
		}
	}
}