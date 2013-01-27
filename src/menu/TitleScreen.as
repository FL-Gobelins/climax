package menu 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leonar Carpentier
	 */
	public class TitleScreen extends Sprite 
	{
		
		private var display:IntroScreenAsset = new IntroScreenAsset();
		
		public function TitleScreen() 
		{
			display.clip.gotoAndStop(1);
			addChild(display);
		}
		
	}

}