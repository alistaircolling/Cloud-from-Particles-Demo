package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.flintparticles.common.actions.Age;
	import org.flintparticles.common.actions.ScaleImage;
	import org.flintparticles.common.counters.Counter;
	import org.flintparticles.common.counters.Pulse;
	import org.flintparticles.common.counters.Steady;
	import org.flintparticles.common.counters.ZeroCounter;
	import org.flintparticles.common.displayObjects.Dot;
	import org.flintparticles.common.displayObjects.Rect;
	import org.flintparticles.common.energyEasing.*;
	import org.flintparticles.common.energyEasing.Quadratic;
	import org.flintparticles.common.initializers.AlphaInit;
	import org.flintparticles.common.initializers.ImageClass;
	import org.flintparticles.common.initializers.Lifetime;
	import org.flintparticles.common.initializers.SharedImage;
	import org.flintparticles.twoD.actions.DeathZone;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.actions.TweenToZone;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.Position;
	import org.flintparticles.twoD.initializers.Velocity;
	import org.flintparticles.twoD.renderers.DisplayObjectRenderer;
	import org.flintparticles.twoD.renderers.PixelRenderer;
	import org.flintparticles.twoD.zones.BitmapDataZone;
	import org.flintparticles.twoD.zones.DiscZone;
	import org.flintparticles.twoD.zones.RectangleZone;
	
	public class MainView extends Sprite
	{
		[Embed(source="../assets/butterfly.png")]
		private var Butterfly:Class;
		
		
		public var emitter:Emitter2D;
		private var moveEmitter:Emitter2D;
		
		private var renderer:DisplayObjectRenderer;
		private var deathZone:DeathZone;
		private var sharedImage:SharedImage;
		private var counter:Counter;
		public var emitRate:int = 20;
		public var shape:Shape;
		private var blurFilter:BlurFilter;
		private var velocity:Velocity;
		private var butterfly:Bitmap;
		
		
		public function MainView()
		{
			init();
		}
		private function init():void{
			
			shape = new Shape();
			shape.graphics.beginFill(0xffffff);
			shape.graphics.drawCircle(0,0,50);
			
			butterfly = new Butterfly();
			
			velocity = new Velocity( new DiscZone( new Point( 0, -200), 10, 0 ));
			blurFilter = new BlurFilter(50, 50, 3);
			
			emitter = new Emitter2D();
			renderer = new DisplayObjectRenderer();//new Rectangle(0,0,1024, 768));
			renderer.addEmitter(emitter);
			addChild(renderer);
			
			var dzone:RectangleZone = new RectangleZone( -10, -10, 1024, 2000 );
			deathZone = new DeathZone( dzone, true );
			emitter.addAction( deathZone );
			var dot:Dot = new Dot(10, 0xffffff);
			dot.alpha = .4;
			emitter.addInitializer( new ImageClass( Dot, 10, 0xFFFFFF));			
			counter = new Steady(emitRate);
			emitter.counter = counter;
			emitter.addInitializer( new Position( new DiscZone(new Point(0, 0), 70, 0)));
			emitter.addInitializer( velocity);
			emitter.addInitializer(new Lifetime(60, 65));
			emitter.addAction(new Age());
			emitter.addAction(new Move());
			
			emitter.y = 768+100;
			
			moveEmitter = new Emitter2D();
			renderer.addEmitter(moveEmitter);
			
			startEmitter();		
			//drawBitmap();
			addEventListener(Event.ADDED_TO_STAGE, stageListener);
			
		}
		
		private function stageListener(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, stageListener);
			emitter.x = stage.stageWidth/2;
		}
		
		
		public function drawBitmap():void{
			var s:Bitmap = new Butterfly();			
			addChild(s);
		}
		
		public function startEmitter():void{
			emitter.counter = counter;
			emitter.start();
		}
		
		public function stopEmitter():void{
			emitter.counter = new ZeroCounter();
			emitter.stop();
		}
		
		public function pause(b:Boolean):void{
			trace("pause:"+b);
			if (b){
				emitter.pause();
			}else{
				emitter.resume();
			}
		}
		
		public function setImage(s:String):void{
			trace("setting image:"+s);
			switch(s){
				case "Dot":
					emitter.addInitializer( new ImageClass( Dot, 10, 0xFFFFFF));
					break
				case "Radial Dot":
					emitter.addInitializer( new ImageClass( WhiteRadial));	
					break				
			}			
		}
		
		public function setCounter(s:String):void{
			trace("set counter:"+s);
			switch(s){
				case "Pulse":
					counter = new Pulse(2, emitRate);
					
				break
				case "Steady":
					counter = new Steady(emitRate);
				break
			}
			emitter.counter = counter;
		}
		
		public function gotoBMP():void{
			//emitter.pause();
			trace("go to bmp  ");
			emitter.pause();
			
			moveEmitter.addExistingParticles(emitter.particles);
			
			moveEmitter.addInitializer( new Lifetime( 6 ) );
			//moveEmitter.addAction( new Age( Elastic.easeInOut ) );
			//moveEmitter.addAction(new TweenToZone(new BitmapDataZone(butterfly.bitmapData, butterfly.x, butterfly.y)));
			moveEmitter.addInitializer(velocity);
			moveEmitter.start();
			
			
			//emitter.counter = new ZeroCounter();
			//emitter.removeInitializer(velocity);
			//emitter.addInitializer( new Velocity( new DiscZone( new Point( 0, 0), 10, 0 )));
			//emitter.addInitializer( new Lifetime( 20) );
			//emitter.addAction( new Age( Quadratic.easeInOut ) );
			//emitter.addAction(new TweenToZone(new BitmapDataZone(butterfly.bitmapData, butterfly.x, butterfly.y)));
			//emitter.addAction(new Move());
			//emitter.addAction(new Age());
		}
		
		
		public function addBlur(b:Boolean):void{
			trace("add blur:"+b);
			if(b){
				filters = [blurFilter];
			}else{
				filters = null;
			}
		}
		
		public function setEmitAmount(n:uint):void{
			emitRate = n;
			counter = new Steady(emitRate);
			emitter.counter = counter;
			
		}
		
		
	}
}