package Data
{
	
	/**
	 * ...
	 * @author Franck Labat
	 */
	public class Dialog implements Content 
	{
		private var value:String;
		
		public function Dialog(value:String):void
		{
			this.value = value;
		}
		
		public function play():void
		{
			// Do the stuff
		}
		
		public function toString():String
		{
			return value;
		}
	}
	
}