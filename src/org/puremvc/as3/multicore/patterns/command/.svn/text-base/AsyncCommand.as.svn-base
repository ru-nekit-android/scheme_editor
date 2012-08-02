package org.puremvc.as3.multicore.patterns.command
{
	import org.puremvc.as3.multicore.interfaces.IAsyncCommand;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;	 


	public class AsyncCommand extends SimpleCommand	implements IAsyncCommand 
	{
		
		public function setOnComplete ( value:Function ) : void 
		{ 
			onComplete = value; 
		}
		
		protected function commandComplete () : void
		{
			if( onComplete != null )
			{
				onComplete();
			}
		}
		
		private var onComplete	:	Function;
	}
}

