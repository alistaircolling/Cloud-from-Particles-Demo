package view.clouds
{
	import caurina.transitions.Tweener;
	
	import com.greensock.*;
	import com.greensock.easing.Back;
	import com.greensock.easing.EaseLookup;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Quint;
	import com.greensock.easing.Strong;
	import com.greensock.plugins.BezierPlugin;
	import com.greensock.plugins.BezierThroughPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.utils.Timer;
	
//	import mx.effects.effectClasses.AnimatePropertyInstance;
	
	import utils.Utils;
	import view.Frame2;
	import view.Frame3;

	public class CatManager extends ShapeManager
	{
		
		
		public const HIDE_LOGO:String = "hideLogo";
		
		private var maxRightInit:int = 300;
		private var minRightInit:int = 5;
		private var maxDownInit:int = 20;
		private var minDownInit:int = 5;

		private var timeToSync:Number = 9;//13
		private var fadeInTime:Number = 1;
		private var expandTime:Number = 4;
		private var bezierTime:Number = 1.5;	
		private var fadeOutTime:Number = .3;
		
		private var puffTimer:Timer;
		private var cloudsFadeTimer:Timer;
		private var reapperCloudsTimer:Timer;
		
		
		private var showMoreClouds:Timer;
		private var showMoreWait:int = 6000;
		
		public var initialised:Boolean;
		
		private var kittenText:Kitten;
		private var tigerText:Tiger;
	
		//TODO make front cloud move on once cat is formed
		
		public function CatManager(n:uint, s:String, a:Animator, altern:Boolean)
		{			
			trace("*******************************");			
			trace("*******************************");
			trace("> > > > > > > CatManager Created");
			super(n, 0, s, a, altern);			
		}
		
		override protected function init():void{
			initialised = false;
			super.init();
			mainCloudsinPlace = 0;
			TweenPlugin.activate([BezierPlugin]); 
			TweenPlugin.activate([BezierThroughPlugin]);
			OverwriteManager.init(OverwriteManager.AUTO);
		//	initFrames();
			cacheAsBitmap = true;

			kittenText = new Kitten();
			tigerText = new Tiger();
			addChild(kittenText);
			addChild(tigerText);
			kittenText.alpha = 0;
			tigerText.alpha = 0;
			
			kittenText.x = -100;//21;
			kittenText.y = 36;
			tigerText.x = 300;//200;
			tigerText.y = 150;
		}
		
		
		
		private function mOv(m:MouseEvent):void{
			trace("mMove! ! ! ! ! ! ! !");
			
		}
		
		override public function initClouds():void{
			
		}
		
		//create clouds then initialize them
		public function initSmallClouds():void{
			
				trace("--------  totalClouds:"+totalClouds);
				for (var i:uint = 1; i<=totalClouds; i++){
					var cloud:BasicCloud;
					if (!initialised){
						cloud = new BasicCloud(i, animal, renderer);
						addChild(cloud);
						mainClouds[i] = cloud;
						cloud.alpha = 0;
					}else{
						cloud = mainClouds[i];
						cloud.alpha = 0;
					}
					trace("adding clouds");
				}
				trace("SHOULD BE DISPATCHING EVENT");
				dispatchEvent(new Event("initialised"));
				initialised = true;
				//initializeCloudsTopRight();
		}
		
		public function expand():void{
			cloudsFadeTimer = new Timer(1700, 1);
			cloudsFadeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, fadeSmallBannerClouds);
			cloudsFadeTimer.start();
		}
		
		private function reShowClouds(e:Event = null):void{
			trace("reshowClouds");
			
			reShowCloud(mainClouds[2] as BasicCloud);
		//	moveCloudFromRight(cloudsAr[3] as BasicCloud);
		//	moveCloudFromRight(cloudsAr[3] as BasicCloud);
			reShowCloud(mainClouds[4] as BasicCloud);
			
			showMoreClouds = new Timer(showMoreWait, 1);
			showMoreClouds.addEventListener(TimerEvent.TIMER_COMPLETE, showMoreClds); 
			showMoreClouds.start();
		}
		
		private function showMoreClds(t:TimerEvent = null):void{
			moveCloudFromFarRight(mainClouds[1] as BasicCloud);
			moveCloudFromFarRight(mainClouds[3] as BasicCloud);
			reShowCloud(mainClouds[5] as BasicCloud);
		}
		private function removeBlur(c:BasicCloud):void{
			TweenMax.to(c, 0, {blurFilter:{blurX:0, blurY:0}});
		}
		
		private function moveCloudFromFarRight(c:BasicCloud):void{
			removeBlur(c);
			c.x = 600;
			c.y = 0;
			c.scaleX = 1;
			c.scaleY = 1;
			c.alpha = 1;
			TweenMax.to(c, 160, {x:-600});
		}
		
		private function moveCloudFromRight(c:BasicCloud):void{
			removeBlur(c);
			c.x = 100;
			c.y = 0;
			c.scaleX = 1;
			c.scaleY = 1;
			c.alpha = 0;
			TweenMax.to(c, 5, {alpha:1});
			TweenMax.to(c, 10+Utils.ranRange(10,15), {x:0, ease:Quint.easeOut});
			
		}
		private function reShowCloud(c:BasicCloud):void{
			
			c.y = 0;
			c.scaleX = 1;
			c.scaleY = 1;
			var tmpXRight:Number = Utils.ranRange(30, 100);
			c.x = 0;//tmpXRight;
			TweenMax.to(c, 3+Utils.ranRange(2, 4), { blurFilter:{blurX:0, blurY:0}, alpha:1, overwrite:true, ease:Linear.easeNone});
		}
		private function fadeSmallBannerClouds(t:TimerEvent=null):void{
			//fade clouds
			moveCloud(mainClouds[1] as BasicCloud);
			moveCloud(mainClouds[2] as BasicCloud);
			moveCloud(mainClouds[3] as BasicCloud);
			moveCloud(mainClouds[4] as BasicCloud);
			moveCloud(mainClouds[5] as BasicCloud);//, true);//, true);		
		
		}
		


		private function fadeBlurCloud(c:BasicCloud):void{
			//TweenMax.to(c, fadeOutTime, {blurFilter{blurX:3, blurY:3}}, alpha:0, ease:Quint.easeInOut});
			TweenMax.to(c, fadeOutTime, {blurFilter:{blurX:3, blurY:3}, alpha:0, ease:Quint.easeInOut});
		}
		//moves a cloud directly to a location
		private function moveCloud(c:BasicCloud):void{
			TweenMax.to(c, .5, {alpha:0});
			TweenMax.to(c, 1, {x:280, y:100, blurFilter:{blurX:4, blurY:6}, overwrite:false, scaleX:.2, scaleY:.2});
		}
		private function bezierCloud(c:BasicCloud, tweenOffAfterwards:Boolean = false):void{
			//TweenLite.to(c, bezierTime, { orientToBezier:true,  bezier:[{x:150, y:-50}, {x:0, y:0}], ease:Linear.easeInOut});
			if (tweenOffAfterwards){
				var bezTime:Number = bezierTime+Utils.ranRange(0, 1);
				TweenMax.to(c, bezTime, { orientToBezier:false,  bezier:[{x:150+Utils.ranRange(-50, 50), y:-160+Utils.ranRange(-40, 40), scaleX:.001*Math.random(), scaleY:.001*Math.random(), alpha:0/*Math.random()*.01*/},{x:30, y:0}, {x:0, y:0, scaleX:1, scaleY:1, alpha:1}], ease:Quint.easeInOut});
				TweenMax.to(c, 40, {x:-600, delay:bezTime+2, overwrite:false, ease:Linear.easeNone});
			}else{
				TweenMax.to(c, bezierTime+Utils.ranRange(2, 5), { orientToBezier:false,  bezier:[{x:150+Utils.ranRange(-50, 50), y:-160+Utils.ranRange(-40, 40), scaleX:.001*Math.random(), scaleY:.001*Math.random(), alpha:Math.random()*0},{x:30, y:0}, {x:0, y:0, scaleX:1, scaleY:1, alpha:1}], ease:Quint.easeInOut});	
			}
			//TweenMax.to(c, bezierTime-1, {scaleX:1, scaleY:1, delay:1, overwrite:false});
			//c.x = 0;
			//c.y = 0;
		}
		
		public function hideSmallCat():void{
			trace(" HIDE SMALL CAT +++++++++++++");
			justHideClouds();
		}
		
		public function reInitialize():void
		{
			trace("reinitialize the cat");
			startClouds();
		}
		
	
		override public function stop():void{
			Tweener.removeAllTweens();
			kittenText.alpha = 0;
			tigerText.alpha = 0;
			super.stop();
		}
		public function startClouds(showSmall:Boolean = false):void{
			trace("STARTCLOUDS IN CATMANAGER");
			for (var i:uint = 1; i<=totalClouds; i++){
				var cloud:BasicCloud = mainClouds[i];
				cloud.scaleX = .5;
				cloud.scaleY = .5;
				cloud.alpha = 0;
				//set clouds to be to the right of their destination
				var ranRight:Number = Utils.ranRange(maxRightInit, minRightInit);
				trace("RAN:"+ranRight);
				//cloud.x = 600+ranRight;
				cloud.x = 300+(i*120);
				Tweener.addTween(cloud, {alpha:1, time:2});
				Tweener.addTween(cloud, {x:0, time:timeToSync/*, transition:"easeOutQuint"*/});
			}
			if (showSmall) startWordsAnim();
		}
		
		private function startWordsAnim():void
		{
			TweenMax.to(kittenText, 1, {alpha:1, x:21, delay:3});
			TweenMax.to(tigerText, 1, {alpha:1, x:200, delay:3.5});			
		}
	
		public function justHideClouds():void
		{
			for (var i:uint = 1; i<=totalClouds; i++){	
				var cloud:BasicCloud = mainClouds[i];
				var tX:int = -300+(i*90);
				tX = Utils.ranRange(-360, -300);
				trace(":;;;"+tX);
				Tweener.addTween(cloud, {x:tX, time:Utils.ranRange(40,48), transition:"easeOutQuint"});
				Tweener.addTween(cloud, {alpha:0, time:Utils.ranRange(7, 10)});
			}
		
		}
		
		public function hideSmallWords():void{
			TweenMax.to(kittenText, .5, {alpha:0});
			TweenMax.to(tigerText, .5, {alpha:0});			
		}

		public function addSideEmitter(d:DisplayObject):void{
			addChildAt(d, 0);
		}
		
		private function mOver(m:MouseEvent):void{
			trace("------mover");
		}

	
		
	}
}