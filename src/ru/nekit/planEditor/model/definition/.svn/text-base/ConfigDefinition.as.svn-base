package ru.nekit.planEditor.model.definition
{
	import flash.utils.getDefinitionByName;
	
	import mx.collections.XMLListCollection;
	
	import ru.nekit.planEditor.GLOBALS;
	import ru.nekit.planEditor.model.definition.element.*;
	import ru.nekit.planEditor.model.definition.layer.*;
	
	public class ConfigDefinition
	{
		
		private var configuration:XML;
		public var defaultLayer:String;
		
		private var _layersDefinition:LayerDefinitionList;
		private var _elementsDefinition:ElementDefinitionList;
		
		public function ConfigDefinition(value:XML = null)
		{
			init(value);
		}
		
		public function init(value:XML):void
		{
			configuration = value;	
			if( value )
			{
				buildLayersDefinition();
				buildElementsDefinition();
			}
		}
		
		public function get layersDefinition():LayerDefinitionList
		{
			return _layersDefinition;
		}
		
		public function get elementsDefinition():ElementDefinitionList
		{
			return _elementsDefinition;
		}
		
		private function  buildLayersDefinition():void
		{
			_layersDefinition 				= new LayerDefinitionList ;
			var layersListRoot:XML 	= configuration.LayersDefinitionList[0];
			defaultLayer				 	= layersListRoot.attribute("default");
			var layersList:XMLList 	= layersListRoot.children();
			var length:uint 				= layersList.length();
			
			for( var i:uint = 0; i < length; i++)
			{
				var layer:XML = layersList[i];
				var layerDefinition:LayerDefinition = new LayerDefinition(layer.attribute("name"),
					layer.attribute("description"), 
					layer.attribute("id"), 
					layer.attribute("depth"),
					layer.attribute("active") == "true"
				/*	Number(layer.attribute("readBit")),
					Number(layer.attribute("editBit")),
					Number(layer.attribute("extraBit"))*/
				);
				_layersDefinition.add(layerDefinition);
			}
		}
		
		private function buildElementsDefinition():void
		{
			_elementsDefinition = new ElementDefinitionList;
			var elementsListRoot:XML 	= configuration.ElementsDefinitionList[0];
			var elementsList:XMLList 	= elementsListRoot.children();
			var length:uint 					=  elementsList.length();
			for( var i:uint = 0; i < length; i++)
			{
				var element:XML 				= elementsList[i];
				var resolveInValue:String 	= element.attribute("resolveIn");
				var resolveInArray:Array 	= resolveInValue == "*" ? [] : resolveInValue.split(",");
				resolveInArray = 	resolveInArray.map(function(element:*, index:Number,  array:Array):LayerDefinition
				{
					return   _layersDefinition.getByID(element);
				});
				const resolveLength:uint = resolveInArray.length;
				var resolveIn:Vector.<LayerDefinition> = new Vector.<LayerDefinition>;
				for( var j:uint = 0 ; j < resolveLength; j++)
					resolveIn.push(resolveInArray[j]);
				var class_:Class;
				var elementDefinition:ElementDefinition = new ElementDefinition(element.attribute("name"),
					element.attribute("description"), 
					element.attribute("type"),
					class_ = getDefinitionByName(GLOBALS.BASE_ELEMENT_PATH + "." + element.attribute("class")) as Class,
					resolveIn,
					_layersDefinition.getByID(element.attribute("mainLayer")),
					getIfEmptyAttribute(element, ElementDefinition.FILL, -1),
					getIfEmptyAttribute(element, ElementDefinition.STROKE, -1),
					getIfEmptyAttribute(element, ElementDefinition.FONT_SIZE, -1),
					getIfEmptyAttribute(element, ElementDefinition.COLOR, -1),
					getIfEmptyAttribute(element, ElementDefinition.TEXT_DECORATION, ElementDefinition.NORMAL),
					getIfEmptyAttribute(element, ElementDefinition.FONT_WEIGHT, 		ElementDefinition.NORMAL),
					getIfEmptyAttribute(element, ElementDefinition.FONT_STYLE, 			ElementDefinition.NORMAL)
				);
				_elementsDefinition.add(elementDefinition);
			}
		}
		
		private static function getIfEmptyAttribute(element:XML, name:String, value:* ):*
		{
			var style:Namespace = GLOBALS.STYLE;
			return element.@style::[name].toString() == "" ? value : element.@style::[name];
		}
	}
}