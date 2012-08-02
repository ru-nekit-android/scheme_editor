package ru.nekit.planEditor.model.dataModel
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import ru.nekit.planEditor.model.vo.BuildingVO;
	
	public class BuildingList extends EventDispatcher
	{
		
		private var _list:Vector.<BuildingVO>;
		
		private var _dataProvider:ArrayCollection;
		
		public function BuildingList()
		{
			_list = new Vector.<BuildingVO>;
		}
		
		public function get isEmpty():Boolean
		{
			return _list.length == 0;
		}
		
		public function setData(data:Object):void
		{
			var value:Array = data as Array;
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