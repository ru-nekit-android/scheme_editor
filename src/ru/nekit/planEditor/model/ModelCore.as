package ru.nekit.planEditor.model
{
	
	import ru.nekit.planEditor.model.dataModel.*;
	import ru.nekit.planEditor.model.definition.*;
	import ru.nekit.planEditor.model.definition.element.*;
	import ru.nekit.planEditor.model.definition.layer.*;
	
	public class ModelCore
	{
		
		public var configDefinition:ConfigDefinition
		public var layersDefinition:LayerDefinitionList;			
		public var elementsDefinition:ElementDefinitionList;
		public var pagesData:PageDataItemList;		
		
		public var authLevel:uint = 0;
		
		public const layerDefinitionLink:LayerDefinitionLink = new LayerDefinitionLink;
		
		public const planData:PlanDataItem 						= new PlanDataItem;
		public const currentPlanData:PlanDataItem 			= new PlanDataItem;
		public const streetList:StreetList								= new StreetList;
		
	}
}