package utils {

	import flash.events.Event
	
	public class CustomEvent extends Event
	{
		
		public var data:Object;
		
		public function CustomEvent(type:String, data:Object)
		{
			this.data= data;
			super(type);
		}
	}
}
