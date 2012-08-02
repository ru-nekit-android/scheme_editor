package ru.nekit.planEditor.controller
{
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import ru.nekit.planEditor.NAMES;
	import ru.nekit.planEditor.view.mediator.ApplicationMediator;
	
	public class StartUpCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute( notification:INotification ) : void
		{	
			editor.registerMediator(editor.view, ApplicationMediator.NAME);
			sendNotification(NAMES.CONFIGURATION_COMMAND);
		}
	}
}