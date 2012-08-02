package ru.nekit.planEditor.model.definition.layer
{
	import flash.utils.Dictionary;
	
	import ru.nekit.planEditor.view.plan.LayerMediator;
	
	public class LayerDefinitionLink
	{
		
		private var _list:Dictionary = new Dictionary();
		
		public function add(layerD:LayerDefinition, layer:LayerMediator):void
		{
			_list[layerD] = {layerD: layerD, layer:layer};
		}
		
		public function getLayerDefinition(layer:LayerMediator):LayerDefinition
		{
			for each( var layerO:Object in _list )
			{
				if( layerO.layer == layer )
					return layerO.layerD;
			}
			return null;
		}
		
		public function getLayerMediator(layerD:LayerDefinition):LayerMediator
		{
			for each( var layerO:Object in _list )
			{
				if( layerO.layerD == layerD )
					return layerO.layer;
			}
			return null;
		}
	}
}