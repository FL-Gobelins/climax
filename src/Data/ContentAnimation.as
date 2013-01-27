package Data
{
	/**
	 * ...
	 * @author Franck Labat
	 */
	public class ContentAnimation implements Content
	{
		private var nameReference:String;
		
		public function ContentAnimation(nameReference:String):void
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