package utils
{
	
import com.greensock.TimelineMax;
import com.greensock.TweenMax;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.utils.getDefinitionByName;

	public class Utils
	{
		public static function ranRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		public static function getURL(url:String, window:String = "_blank"):void
        {
            var req:URLRequest = new URLRequest(url);
            trace("getURL getURL getURL getURL getURL getURL", url, window);

            try
            {
                navigateToURL(req, window);
            }
            catch (e:Error)
            {
                trace("Navigate to URL failed", e.message);
            }
        }

	

		public static function returnBitmap(bmpDClass:Class):Bitmap
		{
			var bitmapD:BitmapData = new bmpDClass(1,1) as BitmapData;
			var bMap:Bitmap = new Bitmap(bitmapD);	
			return bMap;
		}
		
		public static function fadeAll(a:Array, speed:Number, target:Number, f:Function = null):void{
			var timeline:TimelineMax = new TimelineMax({onComplete:f});
			timeline.insertMultiple( TweenMax.allTo(a, speed, {alpha:target}), speed);
		}
	}
}