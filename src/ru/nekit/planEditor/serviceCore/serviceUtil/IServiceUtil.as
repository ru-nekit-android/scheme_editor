package  ru.nekit.planEditor.serviceCore.serviceUtil{
	
	import ru.nekit.planEditor.serviceCore.serviceUtil.description.ServiceDescription;
	import ru.nekit.planEditor.serviceCore.serviceUtil.properties.CallObject;
	import ru.nekit.planEditor.serviceCore.serviceUtil.properties.ServiceProcessBehavior;
	
	public interface IServiceUtil{
		function call(serviceDescription:ServiceDescription, processBehavior:ServiceProcessBehavior = null):Boolean;	
		function close():void;	
		function resend():void;	
		function get callObject():CallObject;
	}
}