package ru.nekit.planEditor.view.plan
{
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import ru.nekit.planEditor.PlanEditor;
	import ru.nekit.planEditor.view.plan.component.PlanGrid;
	
	public class PlanGridMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "PlanGridMediator";
		
		public function PlanGridMediator(viewComponent:PlanGrid)
		{
			super(viewComponent);
			initializeNotifier(PlanEditor.KEY);
		}
		
		public function get owner():PlanGrid
		{
			return viewComponent as PlanGrid;
		}
	}
}