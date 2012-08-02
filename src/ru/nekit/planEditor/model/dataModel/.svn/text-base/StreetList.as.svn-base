package ru.nekit.planEditor.model.dataModel
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import ru.nekit.planEditor.model.vo.StreetVO;
	
	public final class StreetList extends EventDispatcher
	{
		
		private var _list:Vector.<StreetVO>;
		private var _buildingList:Array;
		
		private var _dataProvider:ArrayCollection;
		
		public function StreetList()
		{
			_list 				= new Vector.<StreetVO>;
			_buildingList = new Array;
		}
		
		public function get isEmpty():Boolean
		{
			return _list.length == 0;
		}
		
		public function setData(data:Object):void
		{
			var value:Array = data as Array;
			value.sortOn("name", Array.CASEINSENSITIVE);
			const length:uint = value.length;
			for( var i:uint = 0; i< length; i++)
				_list.push(value[i]);
		
			_dataProvider = new ArrayCollection(value);
			dispatchEvent(new Event("dataChanged"));
		}
		
		[Bindable(dataChanged)]
		public function get dataProvider():ArrayCollection
		{
			return _dataProvider;
		}
	}
}