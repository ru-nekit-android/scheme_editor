package ru.nekit.planEditor.serviceCore.serviceCommand{
	
	import ru.nekit.planEditor.serviceCore.serviceUtil.description.AMFSD;
	
	public final class EditorSC{
		
		public static const CLASS:String 							= "EditorService";
		public static const GET_AUTH_LEVEL:String 			= "getAuthLevel";
		
		public static function get authLevel():AMFSD
		{
			return new AMFSD(CLASS, GET_AUTH_LEVEL);
		}
	}
}