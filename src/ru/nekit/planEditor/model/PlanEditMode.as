package ru.nekit.planEditor.model
{
	public final class PlanEditMode
	{
		
		public static const READ_ONLY_MODE:uint	 		= 1;
		public static const EDIT_MODE:uint 						= 0;
		public static const EDIT_COUPLET_MODE:uint 		= 2;
		
		public static var mode:uint;
		
		public static function get isEditMode():Boolean
		{
			return mode ==  EDIT_MODE || mode == EDIT_COUPLET_MODE;
		}
		
		public static function get isReadOnlyMode():Boolean
		{
			return mode == READ_ONLY_MODE;
		}
	}
}