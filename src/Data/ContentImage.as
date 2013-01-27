package Data
{
	
	/**
	 * ...
	 * @author Franck Labat
	 */
	public class ContentImage implements Content
	{
		private var nameReference:String;
		
		public function ContentImage(nameReference:String):void
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