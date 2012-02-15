package view.buttons
{
	import flash.display.Sprite;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import utils.Utils;
	import com.greensock.easing.Quart;
	
	
	public class CTAButton extends MovieClip
	{
		public var _hitArea:Sprite;
		public static const choice:String = "choiceButton";
		public var title:flash.text.TextField
		public var data:uint;
		public var inFront:Sprite;
		public var behind:MovieClip;
		public var flasher:MovieClip;

	    protected var defX:uint = 178;
	    protected var rightX:uint = 205;

		public function CTAButton()
		{

			//addMouseListeners();
			//init();
		}
		
		
		private function init():void
		{
			TweenMax.to(behind, 10, {x:behind.x+Utils.ranRange(-2, 2), yoyo:true, repeat:-1, ease:Quart.easeInOut});
			TweenMax.to(behind, 10, {y:behind.y+Utils.ranRange(-2, 2), yoyo:true, repeat:-1, ease:Quart.easeInOut});		
			TweenMax.to(inFront, 10, {x:inFront.x+Utils.ranRange(-2, 2), yoyo:true,repeat:-1, ease:Quart.easeInOut});
			TweenMax.to(inFront, 10, {y:inFront.y+Utils.ranRange(-2, 2), yoyo:true,repeat:-1, ease:Quart.easeInOut});	
		}
		
	
		
		public function addTitle(s:String):void
		{
			title.text = s;
		}
		
		public function addMouseListeners():void{
			_hitArea.buttonMode = true;
			_hitArea.mouseChildren = false;
			_hitArea.mouseEnabled = true;
			_hitArea.addEventListener(MouseEvent.ROLL_OVER, mOver);
			_hitArea.addEventListener(MouseEvent.ROLL_OUT, mOut);
			_hitArea.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		public function addData(n:uint):void
		{
			data = n;
			trace("data added to choice button");
		}	
		
		private function mOver(m:MouseEvent):void{
			trace("mover");
			flasher.gotoAndPlay(2);
			
		}
		public function showRollover():void
		{
			trace(" show rollover in choice buttonz");
			flasher.gotoAndPlay(2);
			TweenMax.to(inFront, 2, {x:rightX, ease:Quart.easeOut});
		}
		
		public function showRollOut():void
		{
			trace(" show rolloutin choice buttonz");
			TweenMax.to(inFront, 2, {x:defX, ease:Quart.easeOut});
		//	inFront.x = 76;		
		}
		private function mOut(m:MouseEvent):void{
			trace("mout");
		}
		private function clickHandler(m:MouseEvent):void{
			trace("clicked:"+choice);
		}
		
		
		
	}
}