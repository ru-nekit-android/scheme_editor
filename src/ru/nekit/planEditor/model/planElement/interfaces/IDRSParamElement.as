package ru.nekit.planEditor.model.planElement.interfaces
{
	public interface IDRSParamElement
	{
	
		function set param(value:Number):void;
		[BIndable(paramChanged)]
		function get param():Number;
		
	}
}