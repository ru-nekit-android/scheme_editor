package ru.nekit.planEditor.model.dataModel
{
	import flash.utils.Dictionary;
	
	import ru.nekit.planEditor.model.definition.layer.LayerDefinition;
	import ru.nekit.planEditor.model.planElement.BaseElement;
	
	public class PageDataItem
	{
		
		private var _layerList:Dictionary = new Dictionary;
		internal var _index:uint;
		
		public var id:uint;
		public var name:String;
		
		public var current:LayerDefinition;
		
		public function PageDataItem(id:uint = 0, name:String = "")
		{
			this.id 		= id;
			this.name 	= name;
		}
		
		public function add(value:LayerDefinition):void
		{
			_layerList[value] = new LayerDataItem;	
		}
		
		public function get(value:LayerDefinition):LayerDataItem  
		{
			return LayerDataItem(_layerList[value]);
		}
		
		public function get elements(): Vector.<BaseElement>
		{
			var list:Vector.<BaseElement> = new Vector.<BaseElement>;
			for each( var ldm:LayerDataItem in _layerList )
			{
				const length:uint = ldm.length;	
				for( var i:uint = 0 ; i < length; i++)
					list.push(ldm.elements[i]);
			}
			return list;
		}
		
		public function get index():uint
		{
			return _index;
		}
		
		public function clear():void
		{
			for each( var ldm:LayerDataItem in _layerList )
			ldm.clear();
			_layerList = new Dictionary;
		}
	}
}