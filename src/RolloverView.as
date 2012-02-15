package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	
	import org.flintparticles.common.actions.Age;
	import org.flintparticles.common.counters.Counter;
	import org.flintparticles.common.counters.Steady;
	import org.flintparticles.common.counters.TimePeriod;
	import org.flintparticles.common.counters.ZeroCounter;
	import org.flintparticles.common.displayObjects.Dot;
	import org.flintparticles.common.initializers.ImageClass;
	import org.flintparticles.common.initializers.Lifetime;
	import org.flintparticles.common.initializers.SharedImage;
	import org.flintparticles.twoD.actions.DeathZone;
	import org.flintparticles.twoD.actions.MatchVelocity;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.actions.RandomDrift;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.Position;
	import org.flintparticles.twoD.initializers.Velocity;
	import org.flintparticles.twoD.renderers.DisplayObjectRenderer;
	import org.flintparticles.twoD.zones.DiscZone;
	import org.flintparticles.twoD.zones.RectangleZone;
	
	public class RolloverView extends Sprite
	{
		private var block1:Sprite; 
		private var block2:Sprite; 
		private var block3:Sprite; 
		private var block4:Sprite; 
		private var block5:Sprite; 
		private var block6:Sprite; 
		private var block7:Sprite; 
		
		public var emitter:Emitter2D;
		private var renderer:DisplayObjectRenderer;
		private var deathZone:DeathZone;
		private var sharedImage:SharedImage;
		private var blurFilter:BlurFilter;
		private var velocity:Velocity;
		private var counter:Counter;
		
		
		public function RolloverView()
		{
			init();
		}
		
		private function init():void{
			
			createBlocks();
			createEmitter();
			
		}
		
		private function createEmitter():void{
			blurFilter = new BlurFilter(40, 40, 3);
			
			emitter = new Emitter2D();
			renderer = new DisplayObjectRenderer();
			renderer.addEmitter(emitter);
			addChild(renderer);
			
			renderer.filters = [blurFilter];
			
			velocity = new Velocity( new DiscZone( new Point( 0, -90), 10, 0 ));
			
			var dzone:RectangleZone = new RectangleZone( -10, -100, 1024, 2000 );
			deathZone = new DeathZone( dzone, true );
			emitter.addAction( deathZone );
	
			emitter.addInitializer( new ImageClass( Dot, 17, 0xFFFFFF));			
			//counter = new Steady(25);
			counter =  new TimePeriod(30, .5);
			emitter.counter = counter;
			emitter.addInitializer( new Position( new DiscZone(new Point(0, 0), 10, 0)));
			emitter.addInitializer(velocity);
			emitter.addInitializer(new Lifetime(60, 65));
			///emitter.addAction(new MatchVelocity(100, 200));
			emitter.addAction(new Age());
			emitter.addAction(new Move());
			emitter.addAction(new RandomDrift(10,10));
		}
		
		public function stop():void{
			emitter.stop();
		}
		
		private function createBlocks():void{
			for (var i:uint=1; i<7; i++){
				var block:Sprite = this["block"+i];
				block = new Sprite();
				block.graphics.beginFill(0x3F3F3F);
				block.graphics.drawRect(0,i*100,600,30);
				addChild(block);
				block.addEventListener(MouseEvent.ROLL_OVER, rollOverListener);
				block.addEventListener(MouseEvent.ROLL_OUT, rollOutListener);
			}
		}
		
		private function rollOverListener(m:MouseEvent):void{
			startEmitter(m)
			//trace("rollover");
			addEventListener(MouseEvent.MOUSE_MOVE, mMoveListener);
		}
		
		private function startEmitter(m:MouseEvent):void{
			emitter.counter = counter;
			emitter.x = m.localX;
			emitter.y = m.localY;
			emitter.start();
		}
		
		private function mMoveListener(m:MouseEvent):void{
			//trace("mmmove");
			emitter.x = m.localX;
			emitter.y = m.localY;
		}
		
		private function rollOutListener(m:MouseEvent):void{
			//trace("rollout");
			removeEventListener(MouseEvent.MOUSE_MOVE, mMoveListener);
			emitter.counter = new ZeroCounter();
		}
		
		
		
		
		
	}
}