package ru.nekit.planEditor.model.definition.layer
{
	
	
	public class LayerDefinition
	{
		
		public static const ALL:String = "all-layer";
		
		[Bindable]
		public var name:String;
		[Bindable]
		public var description:String;
		public var id:String;
		public var depth:uint;
		public var readBit:Number;
		public var editBit:Number;
		public var extraBit:Number;
		[Bindable]
		public var active:Boolean;
		public var editable:Boolean = true;
		
		public function LayerDefinition(name:String = null, description:String = null,  id:String = null, depth:uint = 1, active:Boolean = true/*, readBit:Number = 0, editBit:Number = 0, extraBit:Number = 0*/)
		{
			this.name 			= name;
			this.id  				= id;
			this.description  = description;
			this.active 			=	active;
			this.depth 			= depth;
			/*this.readBit			= readBit;
			this.editBit			= editBit;
			this.extraBit		= extraBit;*/
		}
	}
}