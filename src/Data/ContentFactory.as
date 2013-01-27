package Data
{
	import Data.Content;
	import Data.Dialog;
	import flash.media.Sound;
	
	/**
	 * Simple factory
	 * @author Franck Labat
	 */
	public class ContentFactory
	{
		public static function build(type:String, value:String):Content
		{
			if (type == "text")
				return new Dialog(value);
			else if (type == "sound")
				return new ContentSound(value);
			else if (type == "image")
				return new ContentImage(value);
			return null;
		}
	}
	
}