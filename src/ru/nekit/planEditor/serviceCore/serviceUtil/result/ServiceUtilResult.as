package ru.nekit.planEditor.serviceCore.serviceUtil.result
{

	import ru.nekit.planEditor.serviceCore.serviceUtil.IServiceUtil;

	public class ServiceUtilResult{
		
		public var serviceUtil:IServiceUtil;
		public var result:Object;
		public var error:Object;
		
		public function ServiceUtilResult(result:Object, error:Object, serviceUtil:IServiceUtil)
		{
			this.result 			= result;
			this.error 			= error;
			this.serviceUtil  = serviceUtil
		}
		
		public function get internalData():Object{
			return serviceUtil.callObject.processBehavior.internalData;
	}
	}
}