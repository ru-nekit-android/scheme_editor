package ru.nekit.planEditor.view.mediator
{
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	import flash.utils.getQualifiedClassName;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import ru.nekit.planEditor.NAMES;
	import ru.nekit.planEditor.PlanEditor;
	import ru.nekit.planEditor.model.PlanEditMode;
	import ru.nekit.planEditor.model.interfaces.ILabel;
	import ru.nekit.planEditor.model.planElement.*;
	import ru.nekit.planEditor.model.planElement.interfaces.IDRSParamElement;
	import ru.nekit.planEditor.view.frame.ElementPropertyFrame;
	
	public class ElementPropertyMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "ElementPropertyMediator";
		
		public function ElementPropertyMediator(viewComponent:ElementPropertyFrame)
		{
			super(viewComponent);
			multitonKey = PlanEditor.KEY;
			owner.ltf.addEventListener(MouseEvent.CLICK, 	handleEvent);
			owner.ctf.addEventListener(MouseEvent.CLICK,	handleEvent);
			owner.rtf.addEventListener(MouseEvent.CLICK, 	handleEvent);
		}
		
		override public function onRegister( ):void
		{
			with( owner )
			{
				visible =
					couplerContainer.visible 			= couplerContainer.includeInLayout 		= 
					drsParamContainer.visible 	= drsParamContainer.includeInLayout = false;
			}
		};
		
		public function show():void
		{
			currentState = "show";
		}
		
		public function hide():void
		{
			currentState = "hide";
		}
		
		public function get owner():ElementPropertyFrame
		{
			return viewComponent as ElementPropertyFrame;
		}
		
		override public function listNotificationInterests():Array
		{
			return[
				NAMES.UPDATE_ELEMENT_GROUP,
				NAMES.STARTUP_COMPLETE
			];
		}
		
		private function update():void
		{
			var plan:PlanFrameMediator 	= editor.view.plan;
			with( owner)
			{
				yCord.stepSize 							= plan.cellSizeY;
				xCord.stepSize 							= plan.cellSizeX;
				widthValue.stepSize 					= plan.cellSizeX;
				heightValue.stepSize 					= plan.cellSizeY;
				widthValue.maximum 					= 1000;
				heightValue.maximum 					= 1000;
				if( elementGroup )
				{
					container.enabled 					= true;
					xCord.maximum						= plan.owner.width 	- elementGroup.width;
					yCord.maximum						= plan.owner.height 	- elementGroup.height;
					couplerContainer.visible 			= couplerContainer.includeInLayout 		= false;
					drsParamContainer.visible 		= drsParamContainer.includeInLayout = false;
					if( elementGroup.length == 1 )
					{
						element 								= elementGroup.getElement(0);
						headLabel.text					= editor.model.elementsDefinition.getByClass(getQualifiedClassName(element)).name;
						if( element is CouplerElement)
						{
							couplerFrequencyContainer.visible = couplerFrequencyContainer.includeInLayout = sizeContainer.visible = sizeContainer.includeInLayout = PlanEditMode.mode != PlanEditMode.EDIT_COUPLET_MODE;
							couplerContainer.visible 				= couplerContainer.includeInLayout = true;
							couplerElement									= CouplerElement(element);
							couplerCount.dataProvider		 	= couplerElement.countDataProvider;
							couplerFrequency.dataProvider 	= couplerElement.frequencyDataProvider;
							couplerCount.selectedItem			= couplerElement.count;
							couplerFrequency.selectedItem	= couplerElement.frequency;
						}else if( element is IDRSParamElement )
						{
							drsParamElement 					= IDRSParamElement(element);
							drsParam.dataProvider			= drsParamElement.paramDataProvider;
							drsParam.selectedItem			= drsParamElement.param;
							drsParamContainer.visible 		= drsParamContainer.includeInLayout = true;
						}else if( element is ILabel )
						{
							labelElement 						= element as ILabel; 
							labelContainer.visible 			= labelContainer.includeInLayout = true;
							emptyBackgroundContainer.visible = emptyBackgroundContainer.includeInLayout = !(element is FlatElement) ;
							ltf.selected 							= ctf.selected = rtf.selected = false;
							switch( labelElement.textAlign )
							{
								
								case TextFormatAlign.LEFT:
									
									ltf.selected = true;
									
									break;
								
								case TextFormatAlign.CENTER:
									
									ctf.selected = true;
									
									break;
								
								case TextFormatAlign.RIGHT:
									
									rtf.selected = true;
									
									break;
								
								default:
									break;
								
							}
						}else
							labelContainer.visible 		= labelContainer.includeInLayout = false;
					}
					else if( elementGroup.length > 1 )
					{
						headLabel.text				= "Группа элементов";
						labelContainer.visible 		= labelContainer.includeInLayout = false;
					}
					else
					{
						headLabel.text				= "Выберите элемент";
						labelContainer.visible 		= labelContainer.includeInLayout =  container.enabled = false;
						element 				= null;
						labelElement 		= null
						couplerElement	= null;
						rsParamElement 	= null;
					}
					widthLabel.editable = heightLabel.editable = elementGroup.length == 1;
				}
				else
				{
					headLabel.text				= "Выберите элемент";
					labelContainer.visible 		= labelContainer.includeInLayout = container.enabled = couplerContainer.visible 		= couplerContainer.includeInLayout = false;
				}
			}
		}
		
		override public function handleNotification(notification:INotification):void
		{
			var body:Object = notification.body;
			switch( notification.name )
			{
				
				case NAMES.UPDATE_ELEMENT_GROUP:
					
					var elmentGroup:ElementGroup = body as ElementGroup;
					owner.elementGroup 					= elmentGroup;
					owner.enabled 							= true;
					update();
					
					break;
				
				case NAMES.STARTUP_COMPLETE:
					
					hide();
					owner.visible = true;
					update();
					
					break;
				
				default:
					break;
				
			}
		}
		
		override public function handleEvent(event:Event):void
		{
			var target:Object = event.target;
			with( owner )
			{
				if( labelElement )
				{
					ltf.selected = ctf.selected = rtf.selected = false;
					switch( target.id )
					{
						
						case ltf.id:
							
							labelElement.textAlign = TextFormatAlign.LEFT;
							ltf.selected = true;
							
							break;
						
						case ctf.id:
							
							labelElement.textAlign = TextFormatAlign.CENTER;
							ctf.selected = true;
							
							break;
						
						case rtf.id:
							
							labelElement.textAlign = TextFormatAlign.RIGHT
							rtf.selected = true;
							
							break;
						
						default:
							break;
					}
				}
			}
		}
	}
}