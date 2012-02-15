package view
{
import com.greensock.TimelineMax;
import com.greensock.TweenMax;
import com.greensock.easing.Quart;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import utils.Utils;

import view.buttons.Frame3Button;

	public class Frame3 extends MovieClip{
	
		public var logo:MovieClip;
		public var win:MovieClip;
		public var clouds:MovieClip;
		public var heavenly:MovieClip;
		public var packsAndCloud:MovieClip;
		private var mcs:Array;
	
	
	
		public function Frame3()
		{
			super();
		//	init();
			prep();
		}
		
		private function prep():void
		{
			
			mcs = new Array();
			mcs = [logo, heavenly, clouds, win];
			for (var i:int = 0; i < mcs.length; i++)
			{
				var m:MovieClip = mcs[i];
				m.alpha = 0;
				m.visible = false;
			}
			packsAndCloud.x = 600;
		}
		
		public function init():void
		{
			var _timeline:TimelineMax = new TimelineMax();
			_timeline.insertMultiple( TweenMax.allTo(mcs, 1, {autoAlpha:1}, 0.7), 0.7);
			trace("should be starting final frame timeline tween");				
			addMouseListener();		
			TweenMax.delayedCall(2,showPack);
		}
		
		public function showPack():void
		{
			var movC:MovieClip = packsAndCloud["packs"];
			TweenMax.to(packsAndCloud, 5, {x:-21, ease:Quart.easeOut});
			TweenMax.to(movC, 3, {alpha:1, delay:4});
		}
		
		

		
		public function addMouseListener():void
		{
			win.mouseEnabled = true;
			win.mouseChildren = false;
			win.buttonMode = true;
			win.useHandCursor = true;
			win.addEventListener(MouseEvent.CLICK, winClicked);
			win.addEventListener(MouseEvent.ROLL_OVER, mOver);
			win.addEventListener(MouseEvent.ROLL_OUT, mOut);			
		}
		
		
		private function mOver(m:MouseEvent):void
		{
			var d:Frame3Button = m.currentTarget as Frame3Button;
			d.showRollover();
		}
		
		private function mOut(m:MouseEvent):void
		{
			var d:Frame3Button = m.currentTarget as Frame3Button;
			d.showRollOut();
		}
		
		public function winClicked(m:MouseEvent):void
		{
			trace("win clicked, should be visiting url");
			Utils.getURL("http://www.lenor.com/", "_blank");
		}
	}

}