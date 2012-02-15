package view
{
import com.greensock.TimelineMax;
import com.greensock.TweenMax;
import com.greensock.plugins.VolumePlugin;

import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;

import utils.Utils;

public class Frame1 extends MovieClip
{
	public static var initX:int = -160;
	public static var initY:int = -112;	
	private var removeClouds:Boolean = false;
	private var whatHeaven:WhatHeavenSmall;
	public var discoverText:MovieClip;
	public var angel:MovieClip;
	public var c1:MovieClip;
	public var c2:MovieClip;
	public var c3:MovieClip;
	public var button:MovieClip;
	private var timeline:TimelineMax;
	private var initialised:Boolean;
	
	public function Frame1()
	{
		initialised = false;
		trace("FRAME 1 ADDED");
		trace("X AND Y SET"+x+":"+y);
		super();
		initialise();
		startAnimation();
	}
	
	public function initialise():void
	{
		trace("init");
		this.x = initX;
		this.y = initY;
		discoverText.alpha = 0;
		angel.alpha = 0;
		button.visible = false;//stored in main clip
		c1.alpha = 0;
		c2.alpha = 0;
		c3.alpha = 0;
		c1.x = 350;
		c2.x = 300+(-1*initX);
		c3.x = 300+(-1*initX);	
		if (!initialised) whatHeaven = new WhatHeavenSmall();
		
		whatHeaven.alpha = 0;
		var p:Point = globalToLocal(new Point(35, 94));
		whatHeaven.x  = p.x;
		whatHeaven.y = p.y;
		if (!initialised) addChild(whatHeaven);
		initialised = true;
	}
	
	public function restart():void{
		//fade all clouds out 
		timeline = new TimelineMax({onComplete:resetAllClouds});
		timeline.insertMultiple( TweenMax.allTo([c1, c2, c3], .5, {alpha:0}), .5);
	}
	
	private function resetAllClouds():void{
		TweenMax.killTweensOf(c1);
		TweenMax.killTweensOf(c2);
		TweenMax.killTweensOf(c3);
		c1.x = 350;
		c2.x = 300+(-1*initX);
		c3.x = 300+(-1*initX);
		removeClouds = false;
		startAnimation();
	}
	
	public function startAnimation():void
	{
		startClouds();
		showItem(angel, true, 1.5, 1);
		showItem(discoverText, true, 1.5, 1.5);
		TweenMax.delayedCall(4, hideAll);
	}
	
	public function stopIt():void{
		trace("stopit");
		showItem(angel, false, .3);
		showItem(discoverText, false, .5);
		TweenMax.to(whatHeaven, .5, {alpha:0});
		removeClouds = true;
		TweenMax.killDelayedCallsTo(hideAll);
	}
	
	public function hideAll():void{
		trace("/ / / / / / / / /hide all");
		TweenMax.to(whatHeaven, .7, {alpha:1, delay:.5});
		TweenMax.to(whatHeaven, .5, {alpha:0, delay:4});
		dispatchEvent(new Event("showCat"));
		showItem(angel, false, .3);
		showItem(discoverText, false, .5);
		removeClouds = true;
	}
	
	private function destroy():void{
		TweenMax.killTweensOf(this);
		TweenMax.killDelayedCallsTo(hideAll);
		while(numChildren>0){
			removeChildAt(0);
		}
	}
	
	private function showItem(mc:MovieClip, b:Boolean, t:Number,  del:Number = 0):void
	{
		var targ:int = 0;
		if(b){
			targ = 1;
		}
		TweenMax.to(mc, t, {alpha:targ, delay:del});
	}
	
	private function startClouds():void
	{
		for (var i:int = 1; i < 4; i++)
		{
			var cloud:MovieClip = this["c"+i];
			TweenMax.to(cloud, .4, {alpha:1});
			moveCloud(cloud);
		}
	}
	
	private function moveCloud(c:MovieClip):void
	{
		var targ:int = 0-c.width+(initX*-1);
		TweenMax.to(c, Utils.ranRange(20, 30), {x:targ, onComplete:resetCloud, onCompleteParams:[c]});
	}
	
	private function resetCloud(c:MovieClip):void{
		trace("reset cloud:"+c);
		c.x = 300+(-1*initX);
		if (removeClouds){
			try{
				removeChild(c);
			}catch(e:*){
				trace("need to debug this");
			}
		}else{
			var targ:int = 0-c.width;
			c.alpha = 1;
			TweenMax.to(c, Utils.ranRange(20, 30), {x:targ, onComplete:resetCloud, onCompleteParams:[c]});
		}
		
	}
	
	
	
	
	
	
	
}

}