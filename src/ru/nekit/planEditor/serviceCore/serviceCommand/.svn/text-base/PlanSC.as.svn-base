package ru.nekit.planEditor.serviceCore.serviceCommand{
	
	import ru.nekit.planEditor.serviceCore.serviceUtil.description.AMFSD;
	
	public final class PlanSC{
		
		public static const CLASS:String 							= "PlanService";
		public static const SAVE:String 								= "save";
		public static const READ:String 								= "read";
		
		public static function save( idBuilding:uint, data:Object):AMFSD
		{
			return new AMFSD(CLASS, SAVE, idBuilding, data);
		}
		
		public static function read( idBuilding:uint):AMFSD
		{
			return new AMFSD(CLASS, READ, idBuilding);
		}
		
		public static function readAddress( idBuilding:uint):AMFSD
		{
			return new AMFSD(CLASS, READ, idBuilding);
		}
	}
}