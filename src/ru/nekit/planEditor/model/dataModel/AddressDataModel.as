package ru.nekit.planEditor.model.dataModel
{
	import ru.nekit.planEditor.model.vo.BuildingVO;
	import ru.nekit.planEditor.model.vo.StreetVO;
	
	public final class AddressDataModel
	{
		
		public var street:StreetVO 		= new StreetVO;
		public var building:BuildingVO 	= new BuildingVO;
		
		public function set(value:AddressDataModel):void
		{
			street.set(value.street);
			building.set(value.building);
		}
		
		public function clear():void
		{
			street.clear();
			building.clear();
		}
	}
}