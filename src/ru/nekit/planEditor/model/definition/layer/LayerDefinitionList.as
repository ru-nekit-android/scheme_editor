package ru.nekit.planEditor.model.definition.layer
{
	
	public class LayerDefinitionList
	{
		
		private const _list:Vector.<LayerDefinition> = new Vector.<LayerDefinition>;
		
		public var current:LayerDefinition;
		
		public function add(value:LayerDefinition):void
		{
			_list.push(value);
		}
		
		public function get(position:uint = 0):LayerDefinition
		{
			return _list[position];
		}
		
		public function getByID(value:String):LayerDefinition
		{
			for( var i:uint = 0 ; i < _list.length; i++)
			{
				if( _list[i].id == value )
					return _list[i];
			}
			return null;
		}
		
		public function get length():uint
		{
			return _list.length;
		}
		
	}
}