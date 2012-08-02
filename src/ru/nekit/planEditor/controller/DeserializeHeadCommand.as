package ru.nekit.planEditor.controller
{
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import ru.nekit.planEditor.NAMES;
	import ru.nekit.planEditor.model.definition.plan.PlanOrientationDefinition;
	
	public class DeserializeHeadCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute( notification:INotification ) : void
		{	
			
			var body:Object 	= notification.body;
			if( body.toXMLString().length != 0 )
			{
				var xml:XML 			= new XML(body);
				sendNotification(NAMES.SET_PLAN_ORIENTATION_MANUAL, (xml.@orientation).toString());
			}
			else
				sendNotification(NAMES.SET_PLAN_ORIENTATION_MANUAL, PlanOrientationDefinition.A4Album.id);
			sendNotification(NAMES.DESERIALIZE_HEAD_COMPLETE, null);
		}
	}
}