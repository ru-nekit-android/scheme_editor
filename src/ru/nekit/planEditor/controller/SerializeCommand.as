package ru.nekit.planEditor.controller
{
	
	import flash.utils.getQualifiedClassName;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import ru.nekit.planEditor.NAMES;
	import ru.nekit.planEditor.model.definition.element.*;
	import ru.nekit.planEditor.model.definition.layer.*;
	import ru.nekit.planEditor.model.dataModel.PageDataItem;
	import ru.nekit.planEditor.model.dataModel.PageDataItemList;
	import ru.nekit.planEditor.model.planElement.*;
	import ru.nekit.planEditor.model.interfaces.ISerialize;
	
	public class SerializeCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute( notification:INotification ) : void
		{	
			const pageDL:PageDataItemList			= editor.model.pagesData;
			const layerDL:LayerDefinitionList 			= editor.model.layersDefinition;
			const elementDL:ElementDefinitionList 	= editor.model.elementsDefinition;
			var result:XML 										= <plan/>;
			const length:uint 									= pageDL.length;
			const layerLength:uint							= layerDL.length;
			sendNotification(NAMES.SERIALIZE_HEAD_COMMAND, result);
			for( var i:uint = 0; i < length; i++)
			{
				const pageD:PageDataItem = pageDL.get(i);
				var pageXML:XML 	= <page/>;	
				pageXML.@["name"] 	= pageD.name;
				for( var j:uint = 0; j < layerLength; j++)
				{
					const layerD:LayerDefinition = layerDL.get(j);
					if( /*layerD.active &&*/  layerD.id != LayerDefinition.ALL )
					{
						var layerXML:XML 	= <layer/>	
						layerXML.@["id"] 	= layerD.id;
						var elength:uint 		= pageD.get(layerD).length;
						for( var k:uint = 0; k < elength ; k++ )
						{
							var elementXML:XML 								= <element/>;
							var elements:Vector.<BaseElement> 	= pageD.get(layerD).elements;
							var element:BaseElement 						= elements[k];
							elementXML 											= ISerialize(element).serialize(elementXML);
							elementXML.@["type"] 						= elementDL.getByClass(getQualifiedClassName(element)).type;
							layerXML.appendChild( elementXML);
						}
						pageXML.appendChild( layerXML);
					}
				}
				result.body.plan += pageXML;
			}	
			sendNotification(NAMES.SERIALIZE_COMPLETE, result);
		}
	}
}