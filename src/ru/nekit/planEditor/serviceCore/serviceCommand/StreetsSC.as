package ru.nekit.planEditor.serviceCore.serviceCommand{
	

	import ru.nekit.planEditor.serviceCore.serviceUtil.description.AMFSD;
	
	public final class StreetsSC{
		
		public static const CLASS:String 							= "StreetService";
		public static const READ:String 								= "read";
		
		public static function get read( ):AMFSD
		{
			return new AMFSD(CLASS, READ);
		}
	}
}