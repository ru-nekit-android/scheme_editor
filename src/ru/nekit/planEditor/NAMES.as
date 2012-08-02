package ru.nekit.planEditor
{
	public class NAMES
	{
		
		public static const SELECTION_AREA_CLEAR:String 				= "selection_clear";
		public static const SELECTION_AREA_UPDATE:String 				= "selection_update";
		
		public static const KEY_DOWN:String 										= "key_down";
		public static const MOUSE_MOVE:String 									= "mouse_move";
		public static const MOUSE_UP:String 										= "mouse_up";
		
		public static const STARTUP_COMMAND:String 						= "startup_command";
		public static const STARTUP_COMPLETE:String 						= "startup_complete";
		
		public static const CONFIGURATION_COMMAND:String 			= "configuration_command";
		
		public static const SET_PLAN_ORIENTATION_MANUAL:String	= "set_plan_orientation_manual";
		public static const SET_PLAN_ORIENTATION:String					= "set_plan_orientation";
		public static const UPDATE_PLAN_EDIT_MODE:String						= "set_plan_edit_mode";
		
		public static const DATA_COMMAND:String 								= "data_command";
		
		public static const DATA_ADDRESS_READ:String 					= "address_read";
		public static const DATA_ADDRESS_READ_SUCCESS:String 	= "address_read_ok";
		public static const DATA_ADDRESS_READ_FAILURE:String 				= "address_read_bad";
		
		public static const DATA_READ_STREETS:String 						= "streets_read";
		public static const DATA_READ_STREETS_SUCCESS:String 	= "streets_read_ok";
		public static const DATA_READ_STREETS_FAILURE:String 		= "streets_read_bad";
		
		public static const DATA_READ_BUILDINGS:String 					= "buildings_read";
		public static const DATA_READ_BUILDINGS_SUCCESS:String  = "buildings_read_ok";
		public static const DATA_READ_BUILDINGS_FAILURE:String 	= "buildings_read_bad";
		
		public static const DATA_READ_PLAN:String 							= "plan_read";
		public static const DATA_READ_PLAN_SUCCESS:String 			= "plan_read_ok";
		public static const DATA_READ_PLAN_FAILURE:String 			= "plan_read_bad";
		
		public static const DATA_SAVE_PLAN:String 							= "plan_save";
		public static const DATA_SAVE_PLAN_SUCCESS:String 			= "plan_save_ok";
		public static const DATA_SAVE_PLAN_FAILURE:String 			= "plan_save_bad";
		
		public static const ADD_PAGE:String 										= "add_page";
		public static const REMOVE_PAGE:String 									= "remove_page";
		public static const SELECT_PAGE:String 									= "select_page";
		public static const SET_CURRENT_PAGE:String 						= "set_current_page";
		
		public static const REGISTER_LAYER:String 								= "register_layer";
		public static const SELECT_LAYER:String 									= "select_layer";
		public static const SET_CURRENT_LAYER:String 						= "set_current_layer";
		
		public static const REGISTER_ELEMENT:String 							= "register_element";
		public static const ADD_ELEMENT_MANUAL:String 					= "add_element_manual";
		public static const ADD_ELEMENT:String 									= "add_element";
		
		public static const SET_ADDRESS:String										= "set_adress";
		
		public static const CLEAR_PLAN:String 										= "clear_plan";
		public static const CLEAR_ALL:String 										= "clear_all";
		
		public static const UPDATE_ELEMENT_GROUP:String 				= "update_element_group";
		public static const PLAN_SET_FOCUS:String 							= "plan_set_focus";
		
		public static const COPY:String 													= "copy";
		public static const PASTE:String 												= "paste";
		
		public static const SERIALIZE_COMMAND:String 						= "serialize";
		public static const SERIALIZE_COMPLETE:String 						= "serialize_complete";
		public static const SERIALIZE_HEAD_COMMAND:String			= "serialize_head";
		public static const SERIALIZE_HEAD_COMPLETE:String			= "serialize_head_complete";
		
		public static const DESERIALIZE_COMMAND:String 					= "deserialize";
		//public static const DESERIALIZE_LAYER:String 		    			= "deserialize_layer";
		public static const DESERIALIZE_PLAN:String 		    				= "deserialize_plan";
		public static const DESERIALIZE_HEAD_COMMAND:String		=  "deserialize_head";
		public static const DESERIALIZE_HEAD_COMPLETE:String 		=  "deserialize_head_complete";
		public static const DESERIALIZE_COMPLETE:String 					= "deserialize_complete";
		
		public static const CLOSE_DIALOG:String									= "close_dialog";
		
		public static const OPEN_READ_DIALOG:String 						= "show_open_dialog";
		public static const OPEN_READ_DIALOG_OK:String 				= "open_dialog_ok";
		public static const OPEN_SAVE_DIALOG:String 						= "show_save_dialog";
		public static const OPEN_COPY_DIALOG:String 						= "show_copy_dialog";
	}
}