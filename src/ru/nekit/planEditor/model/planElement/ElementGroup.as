package ru.nekit.planEditor.model.planElement
{
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	import ru.nekit.planEditor.NAMES;
	import ru.nekit.planEditor.PlanEditor;
	import ru.nekit.planEditor.model.action.MouseAction;
	import ru.nekit.planEditor.model.interfaces.IDimensional;
	import ru.nekit.planEditor.util.Util;
	
	public class ElementGroup extends Proxy implements IDimensional
	{
		
		public static var mouseAction:MouseAction;
		
		private var _elementList:Vector.<BaseElement> = new Vector.<BaseElement>;
		private var _dimension:Rectangle = new Rectangle;
		
		private var _dragged:Boolean;
		private var _localX:Number;
		private var _localY:Number;
		
		public var bounds:Rectangle;
		
		public function ElementGroup()
		{
			super();
			mouseAction 	= editor.mouseAction;
			multitonKey  	= PlanEditor.KEY;
		}
		
		public function addElement(element:BaseElement):Boolean
		{
			if( !hasElement(element) )
			{
				element.selectionGroup 	= this;
				element.selected = true;
				_elementList.push(element);	
				updateDimension();
				return true;
			}
			return false;
		}
		
		public function removeElement(element:BaseElement):Boolean
		{
			var index:int = elementIndex(element);
			if( index != -1 )
			{
				element.selectionGroup = null;
				_elementList.splice(index,1);
				updateDimension();
				return true;
			}
			return false;
		}
		
		private function updateElementProperty(propery:String, value:*):void
		{
			const length:uint = _elementList.length;
			for( var i:uint = 0 ; i < length; i++)
				_elementList[i][propery] = value;
		}
		
		public function doDrag():void
		{
			if( !_dragged )
			{
				_dragged 	= true;
				_localX 		= 	mouseAction.x - x;
				_localY 		=	mouseAction.y - y;
			}
			x = mouseAction.x - _localX;
			y = mouseAction.y - _localY;
		}
		
		public function stopDrag():void
		{
			_dragged = false;
		}
		
		public function getBoundsValueX(value:Number):Number
		{
			if( bounds )
			{
				if( value < bounds.x )
					value =  bounds.x;
				if( value > bounds.right - width )
					value = bounds.right - width ;
			}
			return value;
		}
		
		public function getBoundsValueY(value:Number):Number
		{
			if( bounds )
			{
				if( value < bounds.y )
					value = bounds.y;
				if( value > bounds.bottom - height )
					value = bounds.bottom - height;
			}
			return value;
		}
		
		public function set x(value:Number):void
		{	
			value = getBoundsValueX(value);
			const length:uint = _elementList.length;
			for( var i:uint = 0 ; i < length; i++)
				_elementList[i].x -= _dimension.x - value;
			_dimension.x =  Util.roundTo(value, editor.view.plan.cellSizeX);
			dispatchEvent(new Event("changed"));
		}
		
		public function set y(value:Number):void
		{
			value = getBoundsValueY(value);
			if( y != value )
			{
				const length:uint = _elementList.length;
				for( var i:uint = 0 ; i < length; i++)
					_elementList[i].y -= _dimension.y - value;
				_dimension.y = Util.roundTo(value,  editor.view.plan.cellSizeY);
				dispatchEvent(new Event("changed"));
			}
		}
		
		[Bindable(changed)]
		public function get x():Number
		{
			return _dimension.x;
		}
		
		[Bindable(changed)]
		public function get y():Number
		{
			return _dimension.y;
		}
		
		[Bindable(changed)]
		public function get width():Number
		{
			return _dimension.width;
		}
		
		public function set addWidth(value:Number):void
		{
			const length:uint = _elementList.length;
			//var j:uint = 0;
			for( var i:uint = 0 ; i < length; i++)
			{
				var element:BaseElement =  _elementList[i];
				if( element.width + value >= element.minWidth && element.width + element.x + value < bounds.right )
				{
					element.width += value;
					/*if( element.x > x )
					element.x += value*j;
					else
					j= 0;
					j++;*/
				}
				else
					break;
			}
			updateDimension();
		}
		
		public function set addHeight(value:Number):void
		{
			const length:uint = _elementList.length;
			//var j:uint = 0;
			for( var i:uint = 0 ; i < length; i++)
			{
				var element:BaseElement =  _elementList[i];
				if( element.height + value >= element.minHeight && element.height + element.y + value < bounds.bottom )
				{
					element.height += value;
					/*if( element.y > y )
					element.y += value*j;
					else
					j= 0;
					j++;*/
				}
				else
					break;
			}
			updateDimension();
		}
		
		public function set width(value:Number):void
		{
			var delta:Number 	=  value - width;
			if( delta )
				addWidth 			= delta;
		}
		
		public function set height(value:Number):void
		{
			var delta:Number   = height - value;
			if( delta )
				addHeight 			= -delta;
		}
		
		[Bindable(changed)]
		public function get height():Number
		{
			return _dimension.height;
		}
		
		public function clear():void
		{
			const length:uint = _elementList.length;
			for( var i:uint = 0 ; i < length; i++)
			{
				var element:BaseElement = _elementList[i];
				element.selected = false;
				element.selectionGroup    	= null;
			}
			if( length != 0 )
			{
				_elementList = new Vector.<BaseElement>;
				updateDimension();
			}
		}
		
		public function elementIndex(value:BaseElement):int
		{
			return _elementList.indexOf(value);
		}
		
		public function hasElement(value:BaseElement):Boolean
		{
			return _elementList.indexOf(value) != -1;
		}
		
		public function getElement(position:uint):BaseElement
		{
			return _elementList[position];
		}
		
		public function updateDimension():Rectangle
		{
			var x:Number 		= 0;
			var y:Number 		= 0;
			var width:Number 	= 0;
			var height:Number = 0;
			const length:uint 	= _elementList.length;
			if( length > 0)
			{
				x 			= _elementList[0].x;
				y 			= _elementList[0].y;
				width 	= _elementList[0].width + x;
				height 	= _elementList[0].height + y;
			}
			for( var i:uint = 1 ; i < length; i++)
			{
				if( x > _elementList[i].x )
					x = _elementList[i].x;
				if( y > _elementList[i].y )
					y = _elementList[i].y;
				if( width < _elementList[i].width + _elementList[i].x )
					width =  _elementList[i].width + _elementList[i].x ;
				if( height < _elementList[i].height  + _elementList[i].y )
					height = _elementList[i].height  + _elementList[i].y;
			}
			_dimension = new Rectangle(x, y, width - x, height - y);
			dispatchEvent(new Event("changed"));
			sendNotification(NAMES.UPDATE_ELEMENT_GROUP, this);
			return _dimension;
		}
		
		public function get dimension():Rectangle
		{
			return _dimension;
		}
		
		public function filterLength(filter:Class):uint
		{
			var result:uint = 0;
			const length:uint = this.length;
			for( var i:uint = 0 ; i< length; i++ )
				if( _elementList[i] is filter)
					result++;
			return result;
		}
		
		public function get length():uint
		{
			return _elementList.length;
		}
		
		public function copy():ElementGroup
		{
			var result:ElementGroup = new ElementGroup;
			const length:uint = _elementList.length;
			for( var i:uint = 0 ; i < length; i++ )
				result.addElement(_elementList[i].copy());
			result.updateDimension();
			return result;
		}
	}
}