package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class ContentSound 
	{
		private var nameReference:String;
		
		public function ContentSound(nameReference:String):void
		{
			this.nameReference = nameReference;
		}
		
		public function play():void
		{
			// Do the stuff
		}
		
		public function toString():String
		{
			return nameReference;
		}
	}
	
}