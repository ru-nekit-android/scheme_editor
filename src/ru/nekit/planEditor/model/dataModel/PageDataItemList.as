package ru.nekit.planEditor.model.dataModel
{
	import ru.nekit.planEditor.model.planElement.BaseElement;
	
	public class PageDataItemList
	{
		
		private var _list:Vector.<PageDataItem> = new Vector.<PageDataItem>;
		
		public var current:PageDataItem;
		
		public function get first():PageDataItem
		{
			return _list[0];
		}
		
		public function get last():PageDataItem
		{
			return _list[_list.length - 1];
		}
		
		public function addElement(value:BaseElement):void
		{
			current.get(current.current).add(value);
		}
		
		public function get next():PageDataItem
		{
			return new PageDataItem( _list.length + 1, (_list.length + 1).toString());
		}
		
		public function add(value:PageDataItem):void
		{
			_list.push(value);
		}
		
		public function remove(page:PageDataItem):PageDataItem
		{
			var index:int = _list.indexOf(page);
			if( index != -1)
			{
				if( _list.length > 1 )
					_list.splice(index, 1);
				page.clear();
				return page;
			}
			return null;
		}
		
		public function get(position:uint = 0):PageDataItem
		{
			return _list[position];
		}
		
		public function getByID(value:uint):PageDataItem
		{
			for( var i:uint = 0 ; i < _list.length; i++)
				if( _list[i].id == value )
					return _list[i];
			return null;
		}
		
		public function get length():uint
		{
			return _list.length;
		}
		
		public function clear():void
		{
			for(var i:uint = 0 ; i < length; i++)
				_list[i].clear();
			_list = new Vector.<PageDataItem>;
		}
		
		public function get elements():Vector.<BaseElement>
		{
			var list:Vector.<BaseElement> = new Vector.<BaseElement>;
			for(var i:uint = 0 ; i < length; i++)
			{
				const elements:Vector.<BaseElement> = _list[i].elements;
				const length:uint = elements.length;
				for(var j:uint = 0 ; j < length; j++)
				{
					list.push( elements[j] );
				}	
			}
			return list;
		}
		
		public function toArray():Array
		{
			var result:Array = new Array;
			const length:uint = _list.length;
			for( var i:uint = 0 ; i < length; i++)
			{
				_list[i]._index = i + 1;
				result.push(_list[i]);
			}
			return result;
		}
	}
}