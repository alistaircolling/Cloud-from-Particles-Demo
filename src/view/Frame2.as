package view
{
import com.greensock.TimelineMax;
import com.greensock.TweenMax;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import utils.Utils;

import view.buttons.Frame3Button;

	public class Frame2 extends MovieClip{
	
		public var whatDo:MovieClip;
		public var rollov:MovieClip;
	
	
		public function Frame2()
		{
			super();
			//init();
		}
		
		public function init():void
		{
			trace("FRAME 2");
			whatDo.alpha = 0;
			rollov.alpha = 0;
			TweenMax.to(whatDo, 1, {alpha:1});
			TweenMax.to(rollov, 1, {alpha:1, delay:.5});			
		}
		
	
	}

}