package org.puremvc.as3.multicore.patterns.command
{
	
	import org.puremvc.as3.multicore.interfaces.IAsyncCommand;
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.interfaces.INotifier;
	import org.puremvc.as3.multicore.patterns.observer.Notifier;	 

	public class AsyncMacroCommand	extends Notifier implements IAsyncCommand, INotifier
	{
		
		public function AsyncMacroCommand()
		{
			subCommands = new Array();
			initializeAsyncMacroCommand();			
		}
	
		protected function initializeAsyncMacroCommand():void {}

		protected function addSubCommand( commandClassRef:Class ): void
		{
			subCommands.push(commandClassRef);
		}		
				
		public function setOnComplete ( value:Function ) : void { onComplete = value; }	
			
		public final function execute( notification:INotification ) : void
		{
			note = notification;
			nextCommand();
		}
		
		private function nextCommand () : void
		{
			if (subCommands.length > 0)
			{
				var commandClassRef:Class	=	subCommands.shift();
				var commandInstance:Object	=	new commandClassRef();
				var isAsync:Boolean			=	commandInstance is IAsyncCommand;
				
				if (isAsync) IAsyncCommand( commandInstance ).setOnComplete( nextCommand );
				ICommand( commandInstance ).initializeNotifier( multitonKey );
				ICommand( commandInstance ).execute( note );
				if (!isAsync) nextCommand();
			}
			else
			{
				if( onComplete != null ) onComplete();
				
				note 		=	null;
				onComplete	=	null;
			}
		} 							

		private var subCommands		:	Array;
		private var note			:	INotification;
		private var onComplete		:	Function;
	}
}