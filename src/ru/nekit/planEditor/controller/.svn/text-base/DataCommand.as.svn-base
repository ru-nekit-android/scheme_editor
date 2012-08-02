package ru.nekit.planEditor.controller
{
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import ru.nekit.planEditor.NAMES;
	import ru.nekit.planEditor.model.dataModel.AddressDataItem;
	import ru.nekit.planEditor.model.dataModel.PlanDataItem;
	import ru.nekit.planEditor.serviceCore.serviceCommand.AddressSC;
	import ru.nekit.planEditor.serviceCore.serviceCommand.PlanSC;
	import ru.nekit.planEditor.serviceCore.serviceUtil.properties.ServiceProcessBehavior;
	import ru.nekit.planEditor.serviceCore.serviceUtil.result.ServiceUtilResult;
	
	public class DataCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute( notification:INotification ) : void
		{	
			
			var body:Object = notification.body;
			var address:AddressDataItem;
			var planData:PlanDataItem;
			
			switch( notification.type )
			{
				
				case NAMES.DATA_READ_STREETS:
					
					AddressSC.streetList.execute(ServiceProcessBehavior.withFunctions(
						function(result:ServiceUtilResult):void
						{
							sendNotification(NAMES.DATA_READ_STREETS_SUCCESS, result.result);
						},
						function(result:ServiceUtilResult):void
						{
							sendNotification(NAMES.DATA_READ_STREETS_FAILURE, result.error);
						}	
					));
					
					break;
				
				case NAMES.DATA_READ_BUILDINGS:
					
					AddressSC.buildingList(body as uint).execute(ServiceProcessBehavior.withFunctions(
						function(result:ServiceUtilResult):void
						{
							sendNotification(NAMES.DATA_READ_BUILDINGS_SUCCESS, result.result);
						},
						function(result:ServiceUtilResult):void
						{
							sendNotification(NAMES.DATA_READ_BUILDINGS_FAILURE, result.error);
						}	
					));
					
					break;
				
				case NAMES.DATA_SAVE_PLAN:
					
					planData = body as PlanDataItem;
					PlanSC.save(planData.address.building.id, planData.toString()).execute(ServiceProcessBehavior.withFunctions(
						function(result:ServiceUtilResult):void
						{	
							sendNotification(NAMES.DATA_SAVE_PLAN_SUCCESS, result.result);
						},
						function(result:ServiceUtilResult):void
						{
							sendNotification(NAMES.DATA_SAVE_PLAN_FAILURE, result.error);
						}	
					));
					
					break;
				
				case  NAMES.DATA_ADDRESS_READ:
					
					AddressSC.get(body as uint).execute(ServiceProcessBehavior.withFunctions(
						function(result:ServiceUtilResult):void
						{
							if( result.result )
							{
								address 				= new  AddressDataItem;
								address.building 	= result.result.building;
								address.street 	= result.result.street;
								sendNotification(NAMES.DATA_ADDRESS_READ_SUCCESS, address);
							}
							else
							{
								sendNotification(NAMES.DATA_ADDRESS_READ_FAILURE, null);
							}
						},
						function(result:ServiceUtilResult):void
						{
							sendNotification(NAMES.DATA_ADDRESS_READ_FAILURE, result.error);
						}	
					));
					
					break
				
				case NAMES.DATA_READ_PLAN:
					
					address = body as AddressDataItem;
					PlanSC.read(address.building.id).execute(ServiceProcessBehavior.withFunctions(
						function(result:ServiceUtilResult):void
						{
							sendNotification(NAMES.DATA_READ_PLAN_SUCCESS, result.result);
						},
						function(result:ServiceUtilResult):void
						{
							sendNotification(NAMES.DATA_READ_PLAN_FAILURE, result.error);
						}	
					));
					
					break;
				
				default:
					break;
			}
		}
	}
}