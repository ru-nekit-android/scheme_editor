package ru.nekit.planEditor.model.dataModel
{
	
	import ru.nekit.planEditor.model.planElement.BaseElement;
	
	public class LayerDataItem
	{
		
		private var _elementList:Vector.<BaseElement> = new Vector.<BaseElement>;
		
		public function LayerDataItem()
		{
			_elementList = new Vector.<BaseElement>;
		}
		
		public function add(element:BaseElement):void
		{
			_elementList.push(element);	
		}
		
		public function remove(value:BaseElement):BaseElement
		{
			return _elementList.splice(elementIndex(value), 1)[0];
		}
		
		public function elementIndex(value:BaseElement):int
		{
			return _elementList.indexOf(value);
		}
		
		public function hasElement(value:BaseElement):Boolean
		{
			return _elementList.indexOf(value) != -1;
		}
		
		public function get length():uint
		{
			return _elementList.length;
		}
		
		public function get elements():Vector.<BaseElement>
		{
			return _elementList;
		}
		
		public function clear():void
		{
			_elementList = new Vector.<BaseElement>;
		}
	}
}