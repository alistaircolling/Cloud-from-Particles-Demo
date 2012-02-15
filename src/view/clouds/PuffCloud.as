﻿package view.clouds{	import flash.display.Bitmap;	import flash.display.Sprite;	import flash.events.Event;	import flash.events.TimerEvent;	import flash.filters.BlurFilter;	import flash.geom.Point;	import flash.utils.Timer;		import org.flintparticles.common.actions.Age;	import org.flintparticles.common.actions.Fade;	import org.flintparticles.common.actions.ScaleImage;	import org.flintparticles.common.counters.Blast;	import org.flintparticles.common.counters.TimePeriod;	import org.flintparticles.common.easing.Quintic;	import org.flintparticles.common.initializers.AlphaInit;	import org.flintparticles.common.initializers.ApplyFilter;	import org.flintparticles.common.initializers.ImageClass;	import org.flintparticles.common.initializers.Lifetime;	import org.flintparticles.common.initializers.ScaleImageInit;	import org.flintparticles.twoD.actions.DeathZone;	import org.flintparticles.twoD.actions.GravityWell;	import org.flintparticles.twoD.actions.MatchVelocity;	import org.flintparticles.twoD.actions.Move;	import org.flintparticles.twoD.actions.RandomDrift;	import org.flintparticles.twoD.actions.TurnTowardsPoint;	import org.flintparticles.twoD.actions.TweenToZone;	import org.flintparticles.twoD.emitters.Emitter2D;	import org.flintparticles.twoD.initializers.Position;	import org.flintparticles.twoD.initializers.Velocity;	import org.flintparticles.twoD.renderers.DisplayObjectRenderer;	import org.flintparticles.twoD.renderers.PixelRenderer;	import org.flintparticles.twoD.zones.BitmapDataZone;	import org.flintparticles.twoD.zones.DiscZone;	import org.flintparticles.twoD.zones.RectangleZone;	import utils.Utils;		public class PuffCloud extends Sprite	{		/*[Embed(source="../../../assets/WhiteRadial.png")]			private var WhiteRadial:Class;						[Embed(source="../../../assets/radialBall.png")]			private var RadialBall:Class;						[Embed(source="../../../assets/catNo3or1or5.png")]			private var CatFaceOptimised:Class;			*/		public static const SHAPE_FORMED:String = "shapeFormed";				private var renderer:DisplayObjectRenderer;		private var emitter:Emitter2D;		private var deathZone:DeathZone;		private var gravityWell:GravityWell;		private var reformTimer:Timer;		private var reformWait:int = 1000;		public var formShape:Bitmap;		private var catFaceOptimised:Bitmap;		private var scaler:ScaleImage;		private var reshowCloudsTimer:Timer;				private var reEmitter:Emitter2D;				public function PuffCloud()		{			//renderer = r;			init();		}		private function init():void{			var dzone:RectangleZone = new RectangleZone( 0, 0, 500, 500 );			deathZone = new DeathZone( dzone, true );			catFaceOptimised = Utils.returnBitmap(CatFaceOptimised);											//RE-EMITTER THAT FILLS THE CLOUD			renderer = new DisplayObjectRenderer();			addChild(renderer);			emitter = new Emitter2D();			renderer.addEmitter(emitter);						reEmitter = new Emitter2D();			renderer.addEmitter(reEmitter);			reEmitter.addAction( deathZone );			reEmitter.counter =  new TimePeriod(150, 4, Quintic.easeInOut);			reEmitter.addInitializer( new ApplyFilter( new BlurFilter( 4, 4, 3)));			reEmitter.addInitializer(new AlphaInit(0.05));			reEmitter.addInitializer( new ImageClass(WhiteRadial));						var placedShape:Position =  new Position( new BitmapDataZone( catFaceOptimised.bitmapData) );   			reEmitter.addInitializer(placedShape);			reEmitter.addAction(new ScaleImage(1, 3));								//	reEmitter.addInitializer(new ScaleImageInit(1, 5));			reEmitter.addInitializer(new Lifetime(18, 20));			reEmitter.addAction(new Move());			reEmitter.addAction(new Age());															emitter.addInitializer(new Lifetime(8, 10));									emitter.addAction(new Age());			var randomDrift:RandomDrift = new RandomDrift(1, 1);						emitter.x = 450;			emitter.y = 125;						emitter.addAction( deathZone );			emitter.counter =  new Blast(300);			emitter.addInitializer( new ApplyFilter( new BlurFilter( 2, 2, 3)));			emitter.addInitializer(new AlphaInit(0.05, .1));			emitter.addInitializer( new ImageClass(WhiteRadial));											///SET THE IMAGE CLASS USED FOR EACH PARTICLE			emitter.addInitializer(new Position(new DiscZone(new Point(0, 0), 50, 0)));			emitter.addInitializer( new Velocity( new DiscZone( new Point( -120, 80 ),70,0 ))); // add movement to the left (actioned by wind)			//emitter.addAction(new ScaleImage(1, 1.5));			//emitter.addAction(new TurnTowardsPoint(400, 600, 100));			emitter.addAction(new MatchVelocity(400, 5));			gravityWell = new GravityWell(1000, 300, 50, 20);			emitter.addInitializer(new Lifetime(8, 10));			emitter.addAction(new Age());//			var randomDrift:RandomDrift = new RandomDrift(1, 1);			emitter.addAction(new Fade(.1,.1));			scaler = new ScaleImage(1, 2);			//emitter.addAction(scaler);						emitter.addAction(new Move());			reformTimer = new Timer(reformWait, 1);			reformTimer.addEventListener(TimerEvent.TIMER_COMPLETE, reformShape);						reshowCloudsTimer = new Timer(2000, 1);			reshowCloudsTimer.addEventListener(TimerEvent.TIMER_COMPLETE, triggerReShowClouds);		}								private function reformShape(t:TimerEvent = null):void{			trace("reform shape");			reEmitter.start();			emitter.addAction(new TweenToZone(new BitmapDataZone(formShape.bitmapData, -30, -50 )));			reshowCloudsTimer.start();					}		private function triggerReShowClouds(t:TimerEvent = null):void{			dispatchEvent(new Event(SHAPE_FORMED));		}					//		private function init():void{//			//			renderer = new DisplayObjectRenderer();//			addChild(renderer);//			//			emitter = new Emitter2D();//			renderer.addEmitter(emitter);//			emitter.x = 450;//			emitter.y = 125;//			//			var dzone:RectangleZone = new RectangleZone( -80, -80, 680, 680 );//			deathZone = new DeathZone( dzone, true );//			emitter.addAction( deathZone );//			//			emitter.counter =  new Blast(100);//new Pulse(3, 50);//new TimePeriod(500, 3, Quint.easeInOut);//			//emitter.addInitializer( new ApplyFilter( new BlurFilter( 6, 6, 3)));//			//add image to define particle shape//			//emitter.addInitializer( new SharedImage( new RadialDot( 10 ) ) );//			emitter.addInitializer( new ImageClass(WhiteRadial));											///SET THE IMAGE CLASS USED FOR EACH PARTICLE//			//add disc zone where particles are created//			//	emitter.addInitializer( new Position( new DiscZone(new Point(0, 0), 50, 0)));//			//var placedShape:Position =  new Position( new BitmapDataZone( cloudBrush.bitmapData ) );      		///SET THE SHAPE THE PARTICLES EMIT FROM//			//emitter.addInitializer( placedShape);//			emitter.addInitializer(new Position(new DiscZone(new Point(0, 0), 50, 0)));//			emitter.addInitializer( new Velocity( new DiscZone( new Point( -160, 80 ),70,0 ))); // add movement to the left (actioned by wind)//			emitter.addInitializer(new AlphaInit(.05, .1));//		//	emitter.addAction(new ScaleImage(1, 1.5));//			emitter.addAction(new TurnTowardsPoint(400, 600, 100));//			//	emitter.addAction(new TurnTowardsPoint(250, 300, 50));//			emitter.addAction(new MatchVelocity(400, 5));//			gravityWell = new GravityWell(1000, 300, 50, 20);//			//	emitter.addAction(gravityWell);//			//	emitter.addInitializer(new ScaleImageInit(3, 7));//			//			//add velocity, a zone where they are going to move to  (same y but to the left of the stage//			//			//randomize the intial size//			//	var scaleImage:ScaleImageInit = new ScaleImageInit( 10, 20 );//			//	emitter.addInitializer( scaleImage );//			//emitter.addInitializer(new //			emitter.addInitializer(new Lifetime(4, 5));//			emitter.addAction(new Age());//			//emitter.addAction(new TweenToZone(new BitmapDataZone(genericCloud.bitmapData, 300, 300 )));//			//			var randomDrift:RandomDrift = new RandomDrift(30, 30);//			//emitter.addAction( new ScaleImage( 1.4, 20 ) );//			//		//	emitter.addAction(new Fade(.05,0));//			emitter.addAction(new ScaleImage(1, 3));//			emitter.addAction(randomDrift);//			emitter.addAction(new Move());//			//		}		public function makePuff():void{			trace("make puff");			formShape = catFaceOptimised;			emitter.start();			reformTimer.start();		}					}}