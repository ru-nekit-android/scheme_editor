package ru.nekit.planEditor.view.plan
{
	
	import flash.display.Graphics;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import ru.nekit.planEditor.NAMES;
	import ru.nekit.planEditor.PlanEditor;
	import ru.nekit.planEditor.model.action.MouseAction;
	import ru.nekit.planEditor.view.plan.component.SelectionArea;
	
	public class SelectionAreaMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "SelectionMediator";
		
		public function SelectionAreaMediator(viewComponent:SelectionArea)
		{
			super(viewComponent);
			initializeNotifier(PlanEditor.KEY);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				NAMES.SELECTION_AREA_UPDATE,
				NAMES.SELECTION_AREA_CLEAR
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var graphics:Graphics = owner.graphics;
			switch( notification.name )
			{
				
				case NAMES.SELECTION_AREA_CLEAR:
					
					graphics.clear();
					
					break;
				
				case NAMES.SELECTION_AREA_UPDATE:
					
					var mouseAction:MouseAction = editor.mouseAction;
					graphics.clear();
					graphics.lineStyle(0, 0x000000, 0.5);
					graphics.beginFill(0x000000, 0.25);
					graphics.drawRect(mouseAction.startX, mouseAction.startY, mouseAction.x - mouseAction.startX, mouseAction.y- mouseAction.startY);
					graphics.endFill();	
					
				default:
					break;
				
			}
		}
		
		public function get owner():SelectionArea
		{
			return viewComponent as SelectionArea;
		}
	}
}