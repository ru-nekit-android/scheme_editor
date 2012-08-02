package ru.nekit.planEditor.view.mediator
{
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import ru.nekit.planEditor.NAMES;
	import ru.nekit.planEditor.view.frame.ToolFrame;
	
	public class ToolMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "ToolMediator";
		
		public function ToolMediator(viewComponent:ToolFrame)
		{
			super(viewComponent);
		}
		
		public function get owner():ToolFrame
		{
			return viewComponent as ToolFrame;
		}
		
		override public function listNotificationInterests():Array
		{
			return[		
				NAMES.STARTUP_COMPLETE
			];
		}
		
		override public function onRegister( ):void
		{
			owner.visible = false;
		};
		
		override public function handleNotification(notification:INotification):void
		{
			var body:Object = notification.body;
			switch( notification.name )
			{
			
				case NAMES.STARTUP_COMPLETE:
					
					hide();
					owner.visible = true;
					
					break;
				
				default:
					break;
				
			}
		}
		
		public function show():void
		{
			currentState = "show";
		}
		
		public function hide():void
		{
			currentState = "hide";
		}
	}
}