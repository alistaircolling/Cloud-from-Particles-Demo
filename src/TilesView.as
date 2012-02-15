package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import view.clouds.BatManager;
	import view.clouds.CatManager;
	
	public class TilesView extends Sprite
	{
		private var batManager:BatManager;
		private var frame:Sprite;
		
		public var expanded:Boolean = true;
		
		public function TilesView()
		{
			init();
			
		}
		
		
		private function init():void{
			frame = new Sprite();
			frame.graphics.beginFill(0x616161);
			frame.graphics.drawRect(0,0,600,600);
			addChild(frame);
			batManager = new BatManager(5, 0, "Bats", this, false);
			addChild(batManager);
		}
		
		public function start():void{
			batManager.startCloudsMain();
		}
		
		public function stop():void{
			batManager.stop();
		}
		
		public function setOutlines(b:Boolean):void{
			batManager.setOutlines(b);
		}
		
		public function showBMPs(b:Boolean):void{
			batManager.showBMPs(b);
		}
		
		
		
	}
}