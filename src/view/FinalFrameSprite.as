package view{
			
import com.greensock.*;
import com.greensock.easing.Quart;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import utils.Utils;

import view.buttons.CTAButton;
import view.buttons.ChoiceButton;

	public dynamic class FinalFrameSprite extends Sprite{
	
		public var logo:MovieClip;
		public var copys:MovieClip;
		public var angel:MovieClip;
		
		
	/*		public var softy:MovieClip;
			public var will:MovieClip;
			public var heavenly:MovieClip;*/
		public var discover:CTAButton;
		/*public var you:MovieClip;
		public var boost:MovieClip;
		public var packsAndCloud:MovieClip;
		*/
		
		
		private var mcs:Array;// = [logo, softy, will, heavenly, discover, you, boost];
		private var route0:Array;// = [logo, softy, will, heavenly, discover];
		private var route1:Array;// = [logo, you, boost, heavenly, discover];
	
		private var _timeline:TimelineMax;
	
	
		public function FinalFrameSprite()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			mcs = [logo, copys, angel, discover];
			route0 = [logo, copys, angel, discover];
			route1 = [logo, copys, angel, discover];
			/*route0 = [logo, softy, will, heavenly, discover]
					route1 = [logo, you, boost, heavenly, discover];*/
			
			for (var i:int = 0; i < mcs.length; i++)
			{
				var m:MovieClip = mcs[i];
				m.alpha = 0;
				m.visible = false;
			}
		}		
		
		public function showResult(n:uint):void
		{
			//0 = softy
			//var toDisplay:Array = this["route"+n];
			//var _timeline:TimelineMax = new TimelineMax();
			//_timeline.insertMultiple( TweenMax.allTo(toDisplay, 0.5, {autoAlpha:1}, 0.7), 0.8);
			TweenMax.to(logo, .5, {autoAlpha:1});
			TweenMax.to(copys, .5, {autoAlpha:1});
			TweenMax.to(angel, .5, {autoAlpha:1});
			TweenMax.to(discover, .5, {autoAlpha:1});
			trace("should be starting final frame timeline tween");				
			addMouseListener();		
		//	var movC:MovieClip = packsAndCloud["packs"];
			/*TweenMax.from(packsAndCloud, 5, {x:600, ease:Quart.easeOut});
						TweenMax.to(movC, 3, {alpha:1, delay:4});*/
		}
		public function addMouseListener():void
		{
			discover.mouseEnabled = true;
			discover.mouseChildren = false;
			discover.buttonMode = true;
			discover.useHandCursor = true;
			discover.addEventListener(MouseEvent.CLICK, discoverClicked);
			discover.addEventListener(MouseEvent.ROLL_OVER, mOver);
			discover.addEventListener(MouseEvent.ROLL_OUT, mOut);			
		}
		
		
		private function mOver(m:MouseEvent):void
		{
			var d:CTAButton = m.currentTarget as CTAButton;
		//	d.showRollover();
		}
		
		private function mOut(m:MouseEvent):void
		{
			var d:CTAButton = m.currentTarget as CTAButton;
		//	d.showRollOut();
		}
		
		
		
		public function discoverClicked(m:MouseEvent):void
		{
			trace("discover clicked, should be visiting url");
			EB.Clickthrough();
		}
		
		
		
		
		
	}
	
	
}
