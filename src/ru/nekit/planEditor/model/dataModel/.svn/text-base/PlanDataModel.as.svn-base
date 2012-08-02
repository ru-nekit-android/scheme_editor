package ru.nekit.planEditor.model.dataModel
{
	import ru.nekit.planEditor.model.definition.plan.PlanOrientationDefinition;
	import ru.nekit.planEditor.model.definition.plan.PlanOrientationDefinitionItem;
	
	public class PlanDataModel
	{
		
		public var address:AddressDataModel;
		public var orientation:PlanOrientationDefinitionItem = PlanOrientationDefinition.A4Album;
		private var _data:XML;
		
		public function PlanDataModel()
		{
			address 	= new AddressDataModel;
		}
		
		public function isNew():Boolean
		{
			return address.street.id == 0 || address.building.id == 0;
		}
		
		public function get version():String
		{
			return head.@version;
		}
		
		public function getLayer(name:String):XMLList
		{
			return body.layer.(@id = name);	
		}
		
		public function get head():XMLList
		{
			return _data.head;
		}
		
		public function get body():XMLList
		{
			return _data.body;
		}
		
		public function equal(value:PlanDataModel):Boolean
		{
			//if( _data.toString() == ""  ) return true;
			return _data.toXMLString() == value._data.toXMLString();
		}
		
		public function set(value:PlanDataModel):void
		{
			setData( new XML(value._data) );
		}
		
		public function setData(data:XML):void
		{
			data.normalize();
			_data = data;	
		}
		
		public function getData():XML
		{
			return _data;
		}
		
		public function toString():String
		{
			return _data.toXMLString();
		}
		
		public function clear():void
		{
			address.street.clear();
			address.building.clear();
		}
	}
}