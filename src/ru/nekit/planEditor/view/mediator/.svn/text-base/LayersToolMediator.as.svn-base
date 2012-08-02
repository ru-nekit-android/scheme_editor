package ru.nekit.planEditor.view.mediator
{
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.IVisualElement;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import ru.nekit.planEditor.NAMES;
	import ru.nekit.planEditor.PlanEditor;
	import ru.nekit.planEditor.model.definition.layer.LayerDefinition;
	import ru.nekit.planEditor.view.frame.LayersToolFrame;
	
	import spark.events.IndexChangeEvent;
	
	public class LayersToolMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "LayersToolMediator";
		
		public function LayersToolMediator(viewComponent:LayersToolFrame)
		{
			super(viewComponent);
			multitonKey 							= PlanEditor.KEY;
			owner.menu.addEventListener(IndexChangeEvent.CHANGE, 	selectHandler);
			owner.menu.dataProvider 	= new ArrayCollection;
		}
		
		public function get owner():LayersToolFrame
		{
			return viewComponent as LayersToolFrame;
		}
		
		override public function listNotificationInterests():Array
		{
			return[
				NAMES.REGISTER_LAYER,
				NAMES.ADD_PAGE,
				NAMES.SELECT_LAYER,
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var body:Object = notification.body;
			switch( notification.name )
			{
				
				case NAMES.REGISTER_LAYER:
					
					if( (body as LayerDefinition).active )
						owner.menu.dataProvider.addItem(body as LayerDefinition);
					
					break;
				
				case NAMES.SELECT_LAYER:
					
					owner.menu.selectedItem = body as LayerDefinition;
					
					break;
				
				default:
					break;
				
			}
		}
		
		private function selectHandler(event:IndexChangeEvent):void
		{
			sendNotification(NAMES.SELECT_LAYER, owner.menu.selectedItem);
		}
	}
}