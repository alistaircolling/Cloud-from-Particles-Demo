package
{
	
	[SWF(width="600", height="600")]
	
	
	import com.greensock.plugins.VolumePlugin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.ButtonAsset;
	
	public class Expander extends Sprite
	{
		private var smallBanner:Animator; 
		private var borders:Sprite;
		private var stopButton:Sprite;
		private var startButton:Sprite;
		private var holder:Sprite;
		
		public function Expander()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageListener);
			addEventListener(MouseEvent.CLICK, stageClick);
		}
		
		
		

		
		private function addedToStageListener(e:Event):void{
			
			mouseChildren = true;
			mouseEnabled = true;
			holder = new Sprite();
			holder.y = -200;
			addChild(holder);
			drawBorders();
			smallBanner = new Animator(600,600, false);
			//smallBanner.x = 300;
			holder.addChild(smallBanner);
			addButton();
			
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, stageClick);
		}
		
		 private function stageClick(e:Event):void {
	           var dispObj = e.target;
	           var a:Array = [];
	           while (dispObj.parent != null) {
		               a.push(dispObj.name)
		               dispObj = dispObj.parent
	           }
	           trace("PATH:", a.reverse().join("."));
      	 }

		private function drawBorders():void{
			borders = new Sprite();
			borders.name = "borders";
			borders.graphics.beginFill(0x0, 0);
			borders.graphics.lineStyle(1, 0xffffff);
			borders.graphics.drawRect(1,1,599,599);
			borders.graphics.drawRect(301, 1, 299, 249);
			holder.addChild(borders);
		}
		
	
		
		private function addButton():void{
			stopButton = new Sprite();
			stopButton.graphics.beginFill(0xFF4258);
			stopButton.graphics.lineStyle(0, 0x0, 0);
			stopButton.graphics.drawRect(0,0,100,30);
			stopButton.y = 600+3;
			stopButton.x = 600 - stopButton.width;
			stopButton.buttonMode = true;
			stopButton.useHandCursor = true;
			stopButton.addEventListener(MouseEvent.CLICK, stopListener);
			holder.addChild(stopButton);
			
			startButton = new Sprite();
			startButton.graphics.beginFill(0xB6FF8C);
			startButton.graphics.lineStyle(0, 0x0, 0);
			startButton.graphics.drawRect(0,0,100,30);
			startButton.y = 600+3;
			startButton.x = 600 - stopButton.width*2-4;
			startButton.buttonMode = true;
			startButton.useHandCursor = true;
			startButton.addEventListener(MouseEvent.CLICK, startListener);
			holder.addChild(startButton);
		}
		
		private function createMask():void{
			
		}
			
		private function startListener(m:MouseEvent):void{
			smallBanner.restart();
		}
		
		private function stopListener(m:MouseEvent):void{
			smallBanner.stop();
		}
		
		
		
		
		
		
		
		
		
		
		
	}
}