package ru.nekit.planEditor.view.plan.component
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	
	import mx.core.UIComponent;
	
	public class PlanGrid extends UIComponent {
		
		public static const POINT_STYLE:String ="point_style";
		public static const GRID_STYLE:String 	="cell_style";
		
		private var _width:Number 		= 0;
		private var _height:Number 	= 0;
		private var _lineColor:uint 		= 0x000000;
		private var _cellSizeX:Number;
		private var _cellSizeY:Number;
		private var _bitmapData:BitmapData;
		private var _bitmap:Bitmap;
		private var _gridStyle:String;
		
		public function init(width:Number, height:Number, cellSizeX:Number, cellSizeY:Number, gridStyle:String = POINT_STYLE,   lineColor:uint = 0x999999):void 
		{	
			_width 				= width;
			_height 			= height;
			_cellSizeX 		=	cellSizeX;
			_cellSizeY 		=	cellSizeY;
			_lineColor 		= lineColor;
			if( _bitmap )
				removeChild(_bitmap);
			_bitmapData 	= new BitmapData(width, height, false, 0xffffff);
			_bitmap 			= new Bitmap(_bitmapData);
			addChild(_bitmap);
			applyStyle();
			this.gridStyle  		= gridStyle;
		}
		
		public function set gridStyle(value:String):void
		{
			if( _gridStyle != value )
			{
				_gridStyle = value;
				applyStyle();
			}
		}
		
		private function draw(limit_1:Number, limit_2:Number, orientation:Boolean):void 
		{
			var lengthX:uint =  Math.round( limit_1/_cellSizeX );
			var lengthY:uint =  Math.round( limit_2/_cellSizeY );
			for( var xi:uint = 0 ; xi <= lengthX; xi++)
			{
				for( var yi:uint = 0 ; yi <= lengthY; yi++)
				{
					var x:uint = xi*_cellSizeX;
					var y:uint = yi*_cellSizeY;
					_bitmapData.setPixel(x, y, _lineColor);
					if( _gridStyle == GRID_STYLE )
						for( var i:uint = 1 ; i <=3 ; i++){
							_bitmapData.setPixel(x, y - i, 0xfadfd0);
							_bitmapData.setPixel(x+ i, y, 0xfadfd0);
							_bitmapData.setPixel(x, y + i, 0xfadfd0);
							_bitmapData.setPixel(x - i, y , 0xfadfd0);
						};
				}
			}
			pixelSnapping = true;
		}
		
		public function set pixelSnapping(value:Boolean):void
		{
			_bitmap.smoothing = !value;
			_bitmap.cacheAsBitmap = true;
			_bitmap.pixelSnapping = value == false ? PixelSnapping.NEVER : PixelSnapping.ALWAYS;
		}
		
		private function applyStyle():void 
		{
			_bitmapData.fillRect(_bitmapData.rect, 0xffffff);
			draw(_width, _height, false);
		}
		
		public function set lineColor(value:uint):void 
		{
			if( _lineColor != value )
			{
				_lineColor = value;
				applyStyle();
			}
		}
		
		public function get lineColor():uint 
		{
			return _lineColor;
		}
		
		public function set cellSizeX(value:Number):void {
			if( _cellSizeX != value )
			{
				_cellSizeX = value;
				applyStyle();
			}
		}
		
		public function set cellSizeY(value:Number):void {
			if( _cellSizeY != value )
			{
				_cellSizeY = value;
				applyStyle();
			}
		}
		
		public function get cellSizeX():Number
		{
			return _cellSizeX;
		}
		
		public function get cellSizeY():Number
		{
			return _cellSizeY;
		}
		
		public override function set width(value:Number):void 
		{
			if( _width != value )
			{
				_width = value;
				applyStyle();
			}
		}
		
		public override function get width():Number {
			return _width;
		}
		
		public override function set height(value:Number):void 
		{
			if( _height != value )
			{
				_height = value;
				applyStyle();
			}
		}
		
		public override function get height():Number {
			return _height;
		}
	}
}