package utils
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	
	public class Tracer extends Sprite
	{
		private var tF:TextField;
		private var textForm:TextFormat;
		
		public function Tracer()
		{
			init();
		}
		
		private function init():void{
			tF = new TextField();
			textForm = new TextFormat("Monaco", 10);
			tF.defaultTextFormat = textForm;
			tF.width = 300;
			tF.height = 600;
			tF.wordWrap = true;
			addChild(tF);		
			
		}
		
		public function log(s:String):void{
			//tF.text += "\r"+s;
		}
		
	}
}