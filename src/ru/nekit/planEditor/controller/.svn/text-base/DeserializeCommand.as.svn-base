package ru.nekit.planEditor.controller
{
	
	import mx.collections.XMLListCollection;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import ru.nekit.planEditor.NAMES;
	import ru.nekit.planEditor.model.dataModel.PageDataItem;
	import ru.nekit.planEditor.model.dataModel.PlanDataItem;
	import ru.nekit.planEditor.model.definition.element.*;
	import ru.nekit.planEditor.model.definition.layer.*;
	import ru.nekit.planEditor.model.planElement.*;
	import ru.nekit.planEditor.model.interfaces.ILabel;
	
	public class DeserializeCommand extends SimpleCommand implements ICommand
	{
		
		private static var plan:PlanDataItem;
		
		private function deserializeLayer(list:XMLListCollection):void
		{
			var maxId:uint 				= 0;
			const length:uint 			= list.length;
			for(var  i:uint = 0; i < length; i++)
			{
				var xmlElement:XML 	= list.getItemAt(i) as XML;
				var type:String 			= xmlElement.@type;
				if( plan.version == "0.11" )
					if( type == "ctv")
						type = "couple";
				var elementD:ElementDefinition = editor.model.elementsDefinition.getByType( type );
				if( elementD )
				{
					var class_:Class 					= elementD.class_;
					var element:BaseElement 	= BaseElement(new class_);
					element.configByDefinition(elementD);
					element.deserialize(xmlElement);
					//BUG in version 0.11
					if( plan.version == "0.11" )
						if( element is ILabel &&  ILabel(element).fontSize == 13 )
							ILabel(element).fontSize 				= elementD.fontSize; 
					maxId 														= Math.max(Number(element.id), maxId);
					sendNotification(NAMES.ADD_ELEMENT, element);
				}
			}
			BaseElement.idCount = maxId;
		}
		
		private function deserializePage(list:XMLListCollection):void
		{
			const length:uint 			= list.length;
			for( var  i:uint = 0; i < length; i++ )
			{
				var layerD:LayerDefinition = editor.model.layersDefinition.getByID(list[i].@id);
				if( layerD )
				{
					sendNotification(NAMES.SET_CURRENT_LAYER, layerD);
					deserializeLayer( new XMLListCollection( list[i].element ) );
				}
			}
		}
		
		override public function execute( notification:INotification ) : void
		{	
			
			var body:Object = notification.body;
			
			switch( notification.type )
			{
				
				/*case NAMES.DESERIALIZE_LAYER:
					
					deserializeLayer( body as XMLListCollection );
					sendNotification(NAMES.DESERIALIZE_COMPLETE, null, NAMES.DESERIALIZE_LAYER);
					
					break;
				*/
				
				case NAMES.DESERIALIZE_PLAN:
					
					plan									= body as PlanDataItem;
					var xml:XML 					= plan.getData();
					var pagesList:XMLList		= xml.body.page;
					const pageLength:uint  = pagesList.length();
					sendNotification(NAMES.DESERIALIZE_HEAD_COMMAND, xml.head);
					var pageD:PageDataItem;
					if( pageLength == 0 )
					{
						pageD = new PageDataItem(1, "1");
						sendNotification(NAMES.ADD_PAGE, 			pageD);
						sendNotification(NAMES.SET_CURRENT_PAGE, 	pageD); 
						deserializePage( new XMLListCollection( xml.body.layer ) );
					}
					else
						for( var i:uint = 0; i < pageLength; i++)
						{
							pageD = new PageDataItem(Number(pagesList[i].@name), pagesList[i].@name);
							sendNotification(NAMES.ADD_PAGE,			pageD);
							sendNotification(NAMES.SET_CURRENT_PAGE, 	pageD); 
							deserializePage( new XMLListCollection( pagesList[i].layer ) );
						}
					sendNotification(NAMES.DESERIALIZE_COMPLETE/*, null, NAMES.DESERIALIZE_PLAN*/);
					
					break;
				
				default:
					
					break;
				
			}
		}
	}
}