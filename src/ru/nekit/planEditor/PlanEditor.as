package ru.nekit.planEditor
{
	
	import flash.errors.IllegalOperationError;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	import ru.nekit.planEditor.controller.*;
	import ru.nekit.planEditor.model.ModelCore;
	import ru.nekit.planEditor.model.action.*;
	import ru.nekit.planEditor.view.mediator.ApplicationMediator;
	
	public class PlanEditor extends Facade
	{
		
		public static const KEY:String = "main";
		
		private static var _instance:PlanEditor;	
		private static var localInstantiation:Boolean;
		
		[Bindable]
		public var view:ApplicationMediator;
		public const model:ModelCore 				= new  ModelCore;
		
		public const mouseAction:MouseAction 	= new MouseAction;
		public const keyAction:KeyAction		  	= new KeyAction;
		
		public function PlanEditor()
		{
			if( localInstantiation )
			{
				super(KEY);
			}   
			else
			{
				throw new IllegalOperationError("PlanEditor is a singleton. Use PlanEditor.instance to obtain an instance of this class.");
			}
		}
		
		public static function get instance():PlanEditor
		{
			if( !_instance )
			{
				localInstantiation 	= true;
				_instance     			= new PlanEditor;
				localInstantiation		= false;	
			}
			return _instance;
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
			registerCommand(NAMES.STARTUP_COMMAND, 					StartUpCommand);
			registerCommand(NAMES.CONFIGURATION_COMMAND, 	ConfigurationCommand);
			registerCommand(NAMES.SERIALIZE_COMMAND, 				SerializeCommand);
			registerCommand(NAMES.SERIALIZE_HEAD_COMMAND, 		SerializeHeadCommand);
			registerCommand(NAMES.DESERIALIZE_COMMAND,			DeserializeCommand);	
			registerCommand(NAMES.DESERIALIZE_HEAD_COMMAND,	DeserializeHeadCommand);		
			registerCommand(NAMES.DATA_COMMAND, 						DataCommand);
		}
		
		public function startup(application:Main):void
		{
			view = new ApplicationMediator(application);
			sendNotification(NAMES.STARTUP_COMMAND);
		}
	}
}