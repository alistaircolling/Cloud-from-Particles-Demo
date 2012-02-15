package view.clouds
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class BatManager extends ShapeManager
	{
		public function BatManager(n:uint, nA:uint, s:String, a:TilesView, altern:Boolean)
		{
			super(n, nA, s, a, altern);
			//tmpSq();	
		}
		
		public function setOutlines(b:Boolean){
			for (var i:uint = 1; i<mainClouds.length; i++){
				var c:BasicCloud = mainClouds[i];
				c.addOutline(b);
			}
		}
		
		public function showBMPs(b:Boolean){
			for (var i:uint = 1; i<mainClouds.length; i++){
				var c:BasicCloud = mainClouds[i];
				c.showBMP(b);
			}
		}
		
	}
}