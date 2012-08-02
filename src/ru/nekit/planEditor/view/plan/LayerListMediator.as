package ru.nekit.planEditor.view.plan
{
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import ru.nekit.planEditor.PlanEditor;
	import ru.nekit.planEditor.model.definition.layer.LayerDefinition;
	import ru.nekit.planEditor.model.dataModel.PageDataItem;
	import ru.nekit.planEditor.model.planElement.BaseElement;
	import ru.nekit.planEditor.view.plan.component.Layer;
	
	import spark.components.Group;
	
	public class LayerListMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "LayerListMediator";
		
		private var _layerList:Vector.<LayerMediator>;		
		private var _page:PageDataItem;
		
		public var current:LayerMediator;
		
		public function LayerListMediator(viewComponent:Group)
		{
			super(viewComponent);
			initializeNotifier(PlanEditor.KEY);
			_layerList = new Vector.<LayerMediator>;
		}
		
		public function get owner():Group
		{
			return viewComponent as Group;
		}
		
		public function registerLayer(layerD:LayerDefinition):LayerMediator
		{
			var layer:LayerMediator 		= new LayerMediator(new Layer);
			layer.owner.id 						= layerD.id;
			var index:uint 						= _layerList.length + 1;
			var mediator:LayerMediator 	= editor.registerMediator(layer, LayerMediator.NAME + layerD.id ) as LayerMediator;
			owner.addElementAt(mediator.owner, index - 1 );
			_layerList.push(mediator);
			if( layerD.depth == 0 )
				mediator.owner.depth 		= index - 1;
			else
				mediator.owner.depth 		= layerD.depth;
			return mediator;
		}
		
		public  function getByIndex(value:uint):LayerMediator
		{
			return _layerList[value];
		}
		
		public  function getById(value:String):LayerMediator
		{
			const length:uint =  _layerList.length;
			for( var i:uint = 0 ; i < length; i++)
				if( _layerList[i].owner.id == value )			
					return _layerList[i];	
			return null;
		}
		
		public  function set page(value:PageDataItem):void
		{
			_page	= value;
			const length:uint = _layerList.length;
			for( var i:uint = 0 ; i < length; i++ )
				_layerList[i].page = value;
		}
		
		public function layerIndex(value:LayerMediator):int
		{
			return _layerList.indexOf(value);
		}
		
		public function hasLayer(value:LayerMediator):Boolean
		{
			return _layerList.indexOf(value) != -1;
		}
		
		public function get length():uint
		{
			return _layerList.length;
		}
	}
}