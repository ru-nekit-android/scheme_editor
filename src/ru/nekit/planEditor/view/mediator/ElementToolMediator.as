package ru.nekit.planEditor.view.mediator
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import ru.nekit.planEditor.NAMES;
	import ru.nekit.planEditor.PlanEditor;
	import ru.nekit.planEditor.model.definition.element.ElementDefinition;
	import ru.nekit.planEditor.model.definition.layer.LayerDefinition;
	import ru.nekit.planEditor.view.frame.ElementToolFrame;
	
	import spark.components.DataRenderer;
	
	public class ElementToolMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "ElementToolMediator";
		
		private var _lastSelectedElement:ElementDefinition;
		
		public function ElementToolMediator(viewComponent:ElementToolFrame)
		{
			super(viewComponent);
			multitonKey = PlanEditor.KEY;
			owner.menu.addEventListener(MouseEvent.CLICK, 					handleEvent);
			owner.menu.dataProvider = new ArrayCollection;
		}
		
		public function get owner():ElementToolFrame
		{
			return viewComponent as ElementToolFrame;
		}
		
		override public function listNotificationInterests():Array
		{
			return[
				NAMES.REGISTER_ELEMENT,
				NAMES.SELECT_LAYER
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var body:Object = notification.body;
			switch( notification.name )
			{
				
				case NAMES.REGISTER_ELEMENT:
					
					owner.menu.dataProvider.addItem(body as ElementDefinition);
					
					break;
				
				case NAMES.SELECT_LAYER:
					
					var layer:LayerDefinition 	= body as LayerDefinition;
					const length:uint 				= editor.model.elementsDefinition.length;
					var hasElements:Boolean	= true;
					for( var i:uint = 0; i < length; i++)
					{
						var element:DataRenderer 	= owner.menu.getElementAt(i) as DataRenderer;
						if( element )
						{
							var data:ElementDefinition 		= element.data as ElementDefinition;
							if(  editor.model.authLevel == 0 )
								element.includeInLayout			= element.visible =   layer.id == LayerDefinition.ALL  ||  data.resolveInLayers.indexOf(layer) != -1 || data.resolveInLayers.length == 0;	
							else
							{
								var resolveLength:uint 	= data.resolveInLayers.length;
								var resolve:Boolean 		= false;
								if( data.mainLayer == layer || data.resolveInLayers.indexOf(layer) != -1 || layer.id == LayerDefinition.ALL )
								{
									resolve = data.mainLayer.editable;
									if( !resolve )
									{
										for( var j:uint= 0; j < resolveLength; j++)
											if( data.resolveInLayers[j].editable)
											{
												resolve = true;
												break;
											}
									}
								}
								element.includeInLayout			= element.visible =  resolve;
								hasElements ||= resolve;
							}
						}
					}
					owner.visible = owner.includeInLayout = hasElements;
					
					break;
				
				default:
					break;
				
			}
		}
		
		override public function handleEvent(event:Event):void
		{
			var mouseEvent:MouseEvent = event as MouseEvent;	
			var target:Object = event.target;
			var layerD:LayerDefinition = editor.model.layersDefinition.current;
			if( mouseEvent )
			{
				var element:ElementDefinition 	= editor.model.elementsDefinition.getByType(target.name);
				if( element.mainLayer && element.resolveInLayers.indexOf(editor.model.layersDefinition.current) == -1 )
				{
					const length:uint = element.resolveInLayers.length;
					if( !element.mainLayer.editable )
					{
						for( var j:uint= 0; j < length; j++)
						{
							if( element.resolveInLayers[j].editable )
							{
								sendNotification(NAMES.SET_CURRENT_LAYER, element.resolveInLayers[j]);
								break;
							}
						}
					}
					else
						sendNotification(NAMES.SET_CURRENT_LAYER, element.mainLayer);
				}
				sendNotification(NAMES.ADD_ELEMENT_MANUAL, new element.class_);
				sendNotification(NAMES.SET_CURRENT_LAYER, layerD);
			}	
		}
	}
}