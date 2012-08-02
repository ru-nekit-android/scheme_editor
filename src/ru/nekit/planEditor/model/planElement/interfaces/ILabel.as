package ru.nekit.planEditor.model.planElement.interfaces
{
	import flash.text.TextFormat;

	public interface ILabel
	{
		[Bindable(labelChanged)]
		function get label():String;
		function set label(value:String):void;
		function get labelTextFormat():TextFormat;
		[Bindable(textAlignChanged)]
		function get textAlign():String;
		function set textAlign(value:String):void;
		function setFocus():void;
		function get restrict():String;
		[Bindable(fontSizeChanged)]
		function get fontSize():uint;
		function set fontSize(value:uint):void;
		[Bindable(colorChanged)]
		function get color():uint;
		function set color(value:uint):void;
		[Bindable(underlineChanged)]
		function get underline():Boolean;
		function set underline(value:Boolean):void;
		[Bindable(boldChanged)]
		function get bold():Boolean;
		function set bold(value:Boolean):void;
		[Bindable(italicChanged)]
		function get italic():Boolean;
		function set italic(value:Boolean):void;
	}
}