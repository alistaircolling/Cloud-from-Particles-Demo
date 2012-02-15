package view.clouds
{
	import flash.display.*;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class PerlinClouds extends MovieClip
	{
		private var bitmap:BitmapData;
		private var angle:Number=0;
		private var _offset:Number=0;
		private var targW:Number;
		private var targH:Number;
		
		
		public function PerlinClouds(w:Number, h:Number)
		{
			targW = w;
			targH = h;
			
			this.init();
		}
		
		private function init():void
		{
			
			this.bitmap=new BitmapData
				(targW,targH,
					true,0xFFFFFFFF);
			var image:Bitmap=new Bitmap(this.bitmap);
			this.addChild(image);
			this.addEventListener
				(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			var point:Point=new Point(this._offset,0);
			this.bitmap.perlinNoise(300,100,2,1000,false,
				true,BitmapDataChannel.ALPHA,false,
				[point,point]);
			this._offset+=2;
		}
	}
}