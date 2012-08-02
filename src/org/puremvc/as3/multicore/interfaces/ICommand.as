package org.puremvc.as3.multicore.interfaces
{

	public interface ICommand extends INotifier
	{
		function execute( notification:INotification ) : void;
	}
}