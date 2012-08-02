package ru.nekit.planEditor.model.planElement
{
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	import ru.nekit.planEditor.PlanEditor;
	import ru.nekit.planEditor.model.definition.element.ElementDefinition;
	import ru.nekit.planEditor.model.interfaces.*;
	import ru.nekit.planEditor.util.Util;
	import ru.nekit.planEditor.view.plan.LayerMediator;
	
	public class BaseElement extends UIComponent  implements ISelectable, IDimensional, ISerialize, IDeserialize
	{
		
		public  static  var idCount:Number = 0;
		
		protected var _fillDefault:uint;
		protected var _strokeDefault:uint;
		
		protected var _defaultColorTransform:ColorTransform;
		protected var _registered:Boolean;
		protected var _selected:Boolean;
		protected var _backgroundVisible:Boolean = true;
		protected var _fill:uint;
		protected var _stroke:uint;
		
		private var _constMinWidth:Number = 0;
		private var _constMinHeight:Number = 0;
		
		public var layer:LayerMediator;
		public var selectionGroup:ElementGroup;
		
		public function BaseElement()
		{
			setMinWidth(40);
			setMinHeight(20);
			_defaultColorTransform 	= transform.colorTransform;
		}
		
		[Bindable(fillChanged)]
		public function get fill():uint
		{
			return _fill;
		}
		
		public function set fill(value:uint):void
		{
			if( _fill != value )
			{
				_fill = value;
				draw();
				dispatchEvent(new Event("fillChanged"));
			}
		}
		
		[Bindable(strokeChanged)]
		public function get stroke():uint
		{
			return _stroke;
		}
		
		public function set stroke(value:uint):void
		{
			if( _stroke != value )
			{
				_stroke = value;
				draw();
				dispatchEvent(new Event("strokeChanged"));
			}
		}
		
		protected function setMinWidth(value:Number):void
		{
			if( minWidth != value )
			{
				super.minWidth = value;
				_constMinWidth  = minWidth;
			}
		}
		
		protected  function setMinHeight(value:Number):void
		{
			if( minHeight != value )
			{
				super.minHeight = value;
				_constMinHeight = value;
			}
		}
		
		protected function get constMinWidth():Number
		{
			return _constMinWidth;
		}
		
		protected function get constMinHeight():Number
		{
			return _constMinHeight;
		}
		
		[Bindable(backgroundVisibleChanged)]
		public function get backgroundVisible():Boolean
		{
			return _backgroundVisible;
		}
		
		public function set backgroundVisible(value:Boolean):void
		{
			if( value != _backgroundVisible)
			{
				_backgroundVisible = value;
				draw();
				dispatchEvent(new Event("backgroundVisibleChanged"));
			}
		}
		
		public function copy():BaseElement
		{
			throw new IllegalOperationError("You must override this function.");
		}
		
		protected function draw():void
		{
			throw new IllegalOperationError("You must override this function.");
		}
		
		public function registerOnLayer():void
		{
			throw new IllegalOperationError("You must override this function.");
		}
		
		public function unregisterOnLayer():void
		{
			throw new IllegalOperationError("You must override this function.");
		}
		
		public function get dimension():Rectangle
		{
			return Util.rectangle(this);
		}
		
		public function get selected():Boolean
		{
			return _selected;	
		}
		
		override public function set x(value:Number):void
		{
			if( super.x != value )
				super.x =  Util.roundTo(value, PlanEditor.instance.view.plan.cellSizeX);
		}
		
		override public function set y(value:Number):void
		{
			if( super.y != value )
				super.y =  Util.roundTo(value, PlanEditor.instance.view.plan.cellSizeY);
		}
		
		override public function set width(value:Number):void
		{
			if( explicitWidth != value )
			{
				explicitWidth = Util.roundTo(value, PlanEditor.instance.view.plan.cellSizeX);
				if( explicitWidth < minWidth )
					explicitWidth = minWidth;
				draw();	
				dispatchEvent(new Event("widthChanged"));	
			}
		}
		
		override public function set height(value:Number):void
		{
			if( explicitHeight != value )
			{
				explicitHeight = Util.roundTo(value, PlanEditor.instance.view.plan.cellSizeY);
				if( explicitHeight < minHeight )
					explicitHeight = minHeight;
				draw();
				dispatchEvent(new Event("heightChanged"));
			}
		}
		
		protected function setWidth(value:Number):void
		{
			if( explicitWidth != value )
			{
				explicitWidth = value;
				draw();
			}
		}
		
		protected function setHeight(value:Number):void
		{
			if( explicitHeight != value )
			{
				explicitHeight = value;
				draw();
			}
		}
		
		[Bindable(widthChanged)]
		override public function get width():Number
		{
			return explicitWidth;
		}
		
		[Bindable(heightChanged)]
		override public function get height():Number
		{
			return explicitHeight;
		}
		
		public function add():BaseElement
		{
			if( layer)
				layer.addElement(this);
			return this;
		}
		
		public function remove():BaseElement
		{
			if( layer)
				layer.removeElement(this);
			return this;
		}
		
		public function serialize(value:XML):XML
		{
			value.@["id"] = id;
			value.@["x"] = x;
			value.@["y"] = y;
			value.@["width"] 		= width;
			value.@["height"] 	= height;
			if( !_backgroundVisible )
				value.@[ElementDefinition.BACKGROUND_VISIBLE] 			= _backgroundVisible;
			if( _fill != _fillDefault )
				value.@[ElementDefinition.FILL]					=  Util.correctInColor(_fill.toString(16));
			if( _stroke != _strokeDefault )
				value.@[ElementDefinition.STROKE] 			=  Util.correctInColor(_stroke.toString(16));
			return value;
		}
		
		public function deserialize(value:XML):void
		{
			x 			= value.@["x"];
			y 			= value.@["y"];
			width 	= value.@["width"];
			height 	= value.@["height"];
			id 			= value.@["id"];
			var backgroundVisibleValue:String = (value.@[ElementDefinition.BACKGROUND_VISIBLE]).toString();
			if( backgroundVisibleValue )
				backgroundVisible 	= backgroundVisibleValue == "true";
			var fill:String =  value.attribute(ElementDefinition.FILL );
			if( fill == "" || !fill )
				_fill 			=  _fillDefault;
			else
				_fill 			= Util.correctOutColor( fill );
			var stroke:String  = value.attribute(ElementDefinition.STROKE );
			if( stroke == "" || !stroke )
				_stroke = _strokeDefault;
			else
				_stroke	= Util.correctOutColor( stroke );
		}
		
		public function set selected(value:Boolean):void
		{
			if( _selected != value )
			{
				if( value )
					transform.colorTransform = new ColorTransform(0.45, 0.75, 1, .8);
				else
					transform.colorTransform = _defaultColorTransform;
				_selected = value;
			}
		}
		
		public function configByDefinition(definition:ElementDefinition):void
		{
			if( definition.fill != -1 )
				_fillDefault			= _fill 						= definition.fill;
			if( definition.stroke != -1 )
				_strokeDefault 	= _stroke					= definition.stroke;
		}
	}
}