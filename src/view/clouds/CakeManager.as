package view.clouds
{
import com.greensock.TweenMax;

import flash.events.Event;

import utils.Utils;

import view.clouds.BasicCloud;
	public class CakeManager extends ShapeManager
	{
		private var carryCloud:Boolean;
		private var _carryCloud:CkCarry;
		private var _cherry:Cherry;
		
		public function CakeManager(n:uint, nA:uint, s:String, a:Animator, altern:Boolean, carryCld:Boolean = true)
		{
			carryCloud = carryCld;
			super(n, nA, s, a, altern);
		}
	
		override public function startCloudsMain():void{
			trace("> > > > > > > > start clouds Cake");
			for (var i:uint = 1; i<=totalClouds; i++){					
				var c:BasicCloud = mainClouds[i];
				c.x = 600;
				c.reset();
				var ranT:Number = Utils.ranRange(4, 10);	
				var targX:int = 0;			
				TweenMax.to(c, ranT, {x:targX, onComplete:cloudInPlace});
			}
			if (carryCloud) {
				moveCherry();
				_carryCloud.alpha = 1;
				_cherry.alpha = 1;
			}			
		}	
		
		override public function hideClouds():void{
			if (carryCloud){
				TweenMax.to(_cherry, .5, {alpha:0});
			}
			super.hideClouds();
		}
		
		private function moveCherry():void{
			var time:Number = 5;
			_cherry.x = 600;
			TweenMax.to(_cherry, time, {x:0});
			_carryCloud.x = 600;
			TweenMax.to(_carryCloud, time*2.7, {x:0-600});
		}
		
		
		override public function initClouds():void{
			if(carryCloud){
				_carryCloud = new CkCarry();
				addChild(_carryCloud);
				_cherry = new Cherry();
				addChild(_cherry);
			}
			super.initClouds();
		}
		
	
		
		override public function stop():void{
			if (carryCloud){
				
				TweenMax.killTweensOf(_carryCloud);
				TweenMax.killTweensOf(_cherry);
				_carryCloud.alpha = 0;
				_cherry.alpha = 0;
			}
			super.stop();
		}
		
		override protected function hideRegularClouds():void{
			for (var i:uint = 1; i<=totalClouds; i++){					
				var c:BasicCloud = mainClouds[i];
				if (i==3){
					trace("SHOULD BE CONVERTING TO PARTICLES");
					c.addEventListener(BasicCloud.RESET_ME, resetCloud);
					c.convertToParticles();
				}else{
					TweenMax.to(c, Utils.ranRange(1, 4), {alpha:0, delay:2});	
				}
			}
			if(alternate){
				showAlternateClouds();
			}
		}	
		
		
		override protected function showRegularClouds():void{
			for (var i:uint = 1; i<=totalClouds; i++){					
				var c:BasicCloud = mainClouds[i];
				if (i==3){
					//slide in from the right as was turned into particles
					TweenMax.to(c, 6, {x:0});
				}else{
					TweenMax.to(c, Utils.ranRange(.3, 3), {alpha:1, delay:Utils.ranRange(0, 3)});
				}
				
			}
			if(alternate){
				TweenMax.delayedCall(8, hideRegularClouds);
			}
		}		
		
	
		private function resetCloud(e:Event):void{
			trace("------------------   RESET CLOUD");
			removeChild(mainClouds[3]);
			var cloud:BasicCloud = new BasicCloud(3, animal , renderer);
			initMainCloud(cloud);
			mainClouds[3] = cloud;
		}
		
		override protected function cloudInPlace():void{
			//used temporarily to stop this working for cake manager
			super.cloudInPlace();
		}
		
		
		
		
		
	}
}