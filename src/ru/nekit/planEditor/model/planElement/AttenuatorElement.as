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
	import ru.nekit.planEditor.model.planElement.interfaces.IDRSParamElement;
	import ru.nekit.planEditor.util.Util;
	
	public class AttenuatorElement extends LabelElement implements IDRSParamElement
	{
		
		protected var _param:Number 					= 0;
		
		public function AttenuatorElement()
		{
			toolTip = "";
			explicitWidth 						= 25;
			explicitHeight 						= 15;
			setMinWidth(25);
			setMinHeight(15);
			_fill										= _fillDefault 			= 0xffdfdf;
			_stroke								= _strokeDefault 	= 0x990000;
			_fontSize								= _fontSizeDefault	= 13;
			_color									= _colorDefault		= 0x000000;
			_labelTextFormat				= new TextFormat("Tahoma", _fontSize, _color,  null, null, null, null, null, TextFormatAlign.CENTER );
			_label.multiline 					= false;
			_label.mouseEnabled 			= false
			_label.autoSize 					= TextFieldAutoSize.CENTER;
		}
		
		public function set param(value:Number):void
		{
			if( _param != value )
			{
				_param = value;	
				updateLabel();
				width								= _label.textWidth + 2;
				dispatchEvent(new Event("paramChanged"));
			}
		}
		
		[BIndable(paramChanged)]
		public function get param():Number
		{
			return _param;
		}
		
		public function get paramDataProvider():ArrayCollection
		{
			return new ArrayCollection([3, 6, 10, 16, 20]);
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
		
		protected function updateLabel():void
		{
			_label.text = "A" + ( _param > 0 ? _param  : "_" );
		}
		
		override public function serialize(value:XML):XML
		{
			value 						= super.serialize(value);
			value.@param 		= _param;
			return value;
		}
		
		override public function deserialize(value:XML):void
		{
			super.deserialize(value);
			_param 		= value.@param;
		}
		
		override public function copy():BaseElement
		{
			var result:AttenuatorElement 		= new AttenuatorElement;
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