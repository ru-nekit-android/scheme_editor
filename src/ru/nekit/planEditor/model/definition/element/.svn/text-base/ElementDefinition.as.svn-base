package ru.nekit.planEditor.model.definition.element
{
	import ru.nekit.planEditor.model.definition.layer.LayerDefinition;
	
	[Bindable]
	public class ElementDefinition
	{
		
		public static  const FILL:String 													= "fill";
		public static  const STROKE:String 											= "stroke";
		public static  const FONT_SIZE:String 										= "font-size";
		public static  const COLOR:String 												= "color";
		public static  const TEXT_ALIGN:String 										= "text-align";
		public static  const TEXT_DECORATION:String 						= "text-decoration";
		public static  const TEXT_DECORATION_UNDERLINE:String		= "underline";
		public static  const FONT_STYLE:String 									= "font-style";
		public static  const FONT_STYLE_ITALIC:String 						= "italic";
		public static  const FONT_WEIGHT:String 								= "font-weight";
		public static  const FONT_WEIGHT_BOLD:String 						= "bold";
		public static  const BACKGROUND_VISIBLE:String 					= "background-visible";
		public static  const NORMAL:String											= "normal";
		
		public var name:String;
		public var type:String;
		public var description:String;
		
		public var class_:Class;
		
		public var resolveInLayers:Vector.<LayerDefinition>;
		public var mainLayer:LayerDefinition;
		
		public var fill:int = -1;
		public var stroke:int = -1;
		public var fontSize:int = -1;
		public var fontColor:int = -1;
		public var underline:Boolean = false;
		public var bold:Boolean = false;
		public var italic:Boolean = false;
		
		public function ElementDefinition(name:String, description:String, type:String, class_:Class, resolveInLayers:Vector.<LayerDefinition>,  mainLayer:LayerDefinition, fill:uint, stroke:uint, fontSize:uint, fontColor:uint, underline:String, bold:String, italic:String)
		{
			this.name 					= name;
			this.description  			= description;
			this.type  					= type;
			this.class_					= class_;
			this.resolveInLayers 	= resolveInLayers;
			this.mainLayer 			= mainLayer;
			this.fill							= fill;
			this.stroke					= stroke;
			this.fontSize				= fontSize;
			this.fontColor				= fontColor;
			this.underline				= underline 	== TEXT_DECORATION_UNDERLINE;
			this.bold						= bold 			== FONT_WEIGHT_BOLD;
			this.italic						= italic 			== FONT_STYLE_ITALIC;
		}
	}
}