package ru.nekit.planEditor.view.plan
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import ru.nekit.planEditor.PlanEditor;
	import ru.nekit.planEditor.model.dataModel.PageDataItem;
	import ru.nekit.planEditor.model.planElement.BaseElement;
	import ru.nekit.planEditor.view.plan.component.Layer;
	
	public class LayerMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "LayerMediator";
		
		private var _enabled:Boolean = true;
		
		public var page:PageDataItem;
		
		public function LayerMediator(viewComponent:Layer)
		{
			super(viewComponent);
			initializeNotifier(PlanEditor.KEY);
		}
		
		public function addElement(value:BaseElement):void
		{
			owner.setFocus();
			value.layer = this;
			if( !value.id )
				value.id = (++BaseElement.idCount).toString();
			owner.addChild(value);
			value.registerOnLayer();
		}
		
		public function removeElement(value:BaseElement):void
		{
			owner.removeChild(value);
			value.unregisterOnLayer();
		}
		
		public function get elements():Vector.<BaseElement>
		{
			return page.get(editor.model.layerDefinitionLink.getLayerDefinition(this)).elements;
		}
		
		public function get length():uint
		{
			return elements.length;
		}
		
		public function get owner():Layer
		{
			return viewComponent as Layer;
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void
		{
			if( _enabled != value )
			{
				_enabled 					= value;
				owner.alpha 			= value ? 1 : .5;
				owner.enabled 		= _enabled;
				if( page )
				{
					const elements:Vector.<BaseElement> = this.elements;
					const length:uint 	= elements.length;
					for( var i:uint = 0 ; i < length; i++)
						elements[i].enabled = value;
				}
			}
		}
	}
}