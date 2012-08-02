package ru.nekit.planEditor.model.clipboard
{
	import ru.nekit.planEditor.model.planElement.ElementGroup;

	public class Clipboard
	{
		
		private var list:Vector.<ElementGroup> = new Vector.<ElementGroup>;
		
		public function Clipboard()
		{
		}
		
		public function clear():void
		{
			list = new Vector.<ElementGroup>;
		}
		
		public function add(value:ElementGroup):void
		{
			list.unshift(value.copy());
		}
		
		public function get(original:Boolean = false):ElementGroup
		{
			return original ? list[0] :  list[0].copy();
		}
		
		public function get length():uint
		{
			return list.length;
		}
		
	}
}