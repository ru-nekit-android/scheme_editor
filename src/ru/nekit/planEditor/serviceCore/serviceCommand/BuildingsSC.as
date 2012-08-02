package ru.nekit.planEditor.serviceCore.serviceCommand{
	
	import ru.nekit.planEditor.serviceCore.serviceUtil.description.AMFSD;
	
	public final class BuildingsSC{
		
		public static const CLASS:String 							= "BuildingService";
		public static const READ:String 								= "read";
		
		public static function read( idStreet:uint):AMFSD
		{
			return new AMFSD(CLASS, READ, idStreet);
		}
	}
}