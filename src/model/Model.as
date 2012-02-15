package model
{
	public class Model
	{
		private var answers:Array;
		private var _result:uint; //0 =  soft, 1 = hard
		
		public function Model()
		{
			init();
		}
		public function init():void
		{
			answers = new Array();
		}
		
		public function calculateResult():void
		{
			var tot:uint = 0;
			_result = 0; //TODO add logic 
			for (var i:int = 0; i < answers.length; i++)
			{
				tot += answers[i];
				trace("total is now:"+tot);				
			}
			if (tot<5){
				_result = 0;
			}else{
				_result = 1;
			}
			trace("result is:"+_result);
		}
		
		public function submitAnswer(a:uint, q:uint):void
		{
			answers[q] = a;
			trace("answer "+a+" submitted for question:"+q);
		}
		
		public function getResult():uint
		{	
			calculateResult();
			trace("returning result form model:"+_result);
			return _result;
		}
		
	}
}