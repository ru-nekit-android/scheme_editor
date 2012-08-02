package ru.nekit.planEditor.model.definition.element
{
	import flash.utils.getQualifiedClassName;
	
	public class ElementDefinitionList
	{
		private const _list:Vector.<ElementDefinition> = new Vector.<ElementDefinition>;
		
		public function add(value:ElementDefinition):void
		{
			_list.push(value);
		}
		
		public function get(position:uint = 0):ElementDefinition
		{
			return _list[position];
		}
		
		public function getByType(value:String):ElementDefinition
		{
			for( var i:uint = 0 ; i < _list.length; i++)
				if( _list[i].type == value )
					return _list[i];
			return null;
		}
		
		public function getByClass(value:String):ElementDefinition
		{
			for( var i:uint = 0 ; i < _list.length; i++)
				if( getQualifiedClassName(_list[i].class_) == value )
					return _list[i];
			return null;
		}
		
		public function get length():uint
		{
			return _list.length;
		}
		
		public function read(xml:XML):void
		{
		}
	}
}