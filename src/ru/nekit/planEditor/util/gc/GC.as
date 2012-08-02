package ru.nekit.planEditor.util.gc{
	
	import flash.events.TimerEvent;
	import flash.net.LocalConnection;
	import flash.utils.Timer;
	
    public class GC {
		
		static private var _gc:GC;
		private var _timer:Timer;
		
        public function GC() {
        	_timer = new Timer ( 10, 10 );
        	_timer.addEventListener( TimerEvent.TIMER, onTimer );
        	_timer.start();
        }
        
        private function onTimer ( e:TimerEvent ) :void {
        	try {
				new LocalConnection().connect('gcForce');
				new LocalConnection().connect('gcForce');
			} catch (err:Error) {
			}
        }
		
        static public function gc ( ) :void {
        	_gc = new GC;
       }
		
    }
}