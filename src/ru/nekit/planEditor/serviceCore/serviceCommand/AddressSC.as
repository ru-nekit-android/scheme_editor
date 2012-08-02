package ru.nekit.planEditor.serviceCore.serviceCommand{
	
	import ru.nekit.planEditor.serviceCore.serviceUtil.description.AMFSD;
	
	public final class AddressSC{
		
		public static const CLASS:String 							= "AddressService";
		public static const GET:String 								= "get";
		public static const STREET_LIST:String					= "streetList";
		public static const BUILDING_LIST:String				= "buildingList";
		
		public static function buildingList( idStreet:uint):AMFSD
		{
			return new AMFSD(CLASS, BUILDING_LIST, idStreet);
		}
		
		public static function get streetList():AMFSD
		{
			return new AMFSD(CLASS, STREET_LIST);
		}
		
		public static function get( idBuildin:uint):AMFSD
		{
			return new AMFSD(CLASS, GET, idBuildin);
		}
	}
}