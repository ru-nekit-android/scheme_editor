package ru.nekit.planEditor.model.planElement
{
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import mx.collections.ArrayCollection;
	
	import ru.nekit.planEditor.PlanEditor;
	import ru.nekit.planEditor.util.Util;
	
	final public class CouplerElement extends LabelElement
	{
		
		private var _count:Number 							= 0;
		private var _frequency:Number 					= 0;
		
		public function CouplerElement()
		{
			toolTip = "";
			explicitWidth 						= 25;
			explicitHeight 						= 15;
			setMinWidth(25);
			setMinHeight(15);
			_fill										= _fillDefault 			= 0xfff5b2;
			_stroke								= _strokeDefault 	= 0x333333;
			_fontSize								= _fontSizeDefault	= 13;
			_color									= _colorDefault		= 0x00ff00;
			_labelTextFormat				= new TextFormat("Tahoma", _fontSize, _color,  null, null, null, null, null, TextFormatAlign.CENTER );
			_label.multiline 					= false;
			_label.mouseEnabled 			= false
			_label.autoSize 					= TextFieldAutoSize.CENTER;
			updateTextFormat();
		}
		
		public function set count(value:Number):void
		{
			if( _count != value )
			{
				_count = value;	
				updateLabel();
				width								= _label.textWidth + 2;
				dispatchEvent(new Event("countChanged"));
			}
		}
		
		public function set frequency(value:Number):void
		{
			if( _frequency != value )
			{
				_frequency = value;	
				updateLabel();
				width								= _label.textWidth + 2;
				dispatchEvent(new Event("frequencyChanged"));
			}
		}
		
		[BIndable(frequencyChanged)]
		public function get frequency():Number
		{
			return _frequency;
		}
		
		[BIndable(countChanged)]
		public function get count():Number
		{
			return _count;
		}
		
		public function get countDataProvider():ArrayCollection
		{
			return new ArrayCollection([0, 1, 2, 3, 4]);
		}
		
		public function get frequencyDataProvider():ArrayCollection
		{
			return new ArrayCollection([0, 6, 8 , 10, 12, 16, 20, 24]);
		}
		
		override public function get label():String
		{
			return "";
		}
		
		override protected function draw():void
		{
			graphics.clear();
			graphics.lineStyle(1, _stroke, _backgroundVisible ? 1 : .1);//, false, LineScaleMode.VERTICAL, CapsStyle.NONE, JointStyle.MITER, 10);
			graphics.beginFill(_fill,  1);
			graphics.drawRect (0, 0, width, height);
			graphics.endFill();	
		}
		
		override public function set width(value:Number):void
		{
			if( width != value )
			{
				super.width = value;
				updateLabelPosition();
			}
		}
		
		override public function set height(value:Number):void
		{
			if( height != value )
			{
				super.height = value;
				updateLabelPosition();
			}
		}
		
		override public function registerOnLayer():void
		{
			if( !_registered )
			{
				draw();
				drawLabel();
				addChild(_label);
				_registered = true;
			}
		}
		
		override protected function drawLabel(selectedMode:Boolean = false):void
		{
			_label.border 						= false;
			_label.background 				= false;
			_label.backgroundColor 		= 0xffffff;
			_label.borderColor 				= 0x000000;
			_label.selectable					= false;
			_label.type							= TextFieldType.DYNAMIC;
			updateLabel();
			updateLabelSize();
			updateLabelPosition();
		}
		
		override protected function updateLabelSize():void
		{
			var textWidth:Number	= Util.roundTo(_label.textWidth  +  PlanEditor.instance.view.plan.cellSizeX / 2, PlanEditor.instance.view.plan.cellSizeX);
			var textHeight:Number 	=_label.textHeight;
			width								= Math.max(width,  textWidth);
			height			 					= Math.max(height,  textHeight);
			minHeight 						= height;
			minWidth  						= Math.max(constMinWidth, textWidth);
			if( selectionGroup )
				selectionGroup.updateDimension();
		}
		
		override protected function updateLabelPosition():void
		{
			_label.x = (width  -  _label.width)/2;
			_label.y = (height - _label.height)/2;
		}
		
		private function updateLabel():void
		{
			_label.text = "T" + ( _count > 0 ?  _count : "_" ) + ( _frequency > 0 ?  ( _frequency < 10 ? "0" : "") +_frequency : "_");
		}
		
		override public function serialize(value:XML):XML
		{
			value 						= super.serialize(value);
			value.@count 			= _count;
			value.@frequency	= _frequency;
			return value;
		}
		
		override public function deserialize(value:XML):void
		{
			super.deserialize(value);
			_count 		= value.@count;
			_frequency	= value.@frequency;
		}
		
		override public function copy():BaseElement
		{
			var result:CouplerElement 		= new CouplerElement;
			result.explicitHeight 				= explicitHeight;
			result.explicitWidth 					= explicitWidth;
			result._count							= _count;
			result._frequency					= _frequency;
			result.x           							= x;
			result.y           							= y;
			result.layer     							= layer;
			result._label.text		    			= _label.text;
			result._labelTextFormat.align = textAlign;
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