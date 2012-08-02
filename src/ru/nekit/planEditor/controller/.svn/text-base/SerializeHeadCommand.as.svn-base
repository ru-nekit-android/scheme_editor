package ru.nekit.planEditor.controller
{
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import ru.nekit.planEditor.GLOBALS;
	import ru.nekit.planEditor.NAMES;
	import ru.nekit.planEditor.model.dataModel.PlanDataItem;
	
	public class SerializeHeadCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute( notification:INotification ) : void
		{	
			var xml:XML = notification.body as XML;
			//xml.addNamespace(GLOBALS.STYLE);
			xml.head.@["version"] 		= GLOBALS.PLAN_VERSION;
			xml.head.@["cell-size-x"] 	= editor.view.plan.cellSizeX;
			xml.head.@["cell-size-y"] 	= editor.view.plan.cellSizeY;
			xml.head.@["orientation"] = editor.model.currentPlanData.orientation.id;
			xml.head.@["address-street-id"] 	= editor.model.currentPlanData.address.street.id;
			xml.head.@["address-building-id"] 	= editor.model.currentPlanData.address.building.id;
			sendNotification(NAMES.SERIALIZE_HEAD_COMPLETE, xml);
		}
	}
}