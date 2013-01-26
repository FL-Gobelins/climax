package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import Gameplay.BubbleSprite;
	
	/**
	 * ...
	 * @author Leonar Carpentier
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//Variables
		
		private var loadingScreen:Sprite;
		
		//Methods
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//init Global variables
			
			//Display Loader
			//TODO TEMP
			loadingScreen = new Sprite();
			loadingScreen.graphics.beginFill(0x000000);
			loadingScreen.graphics.drawRect(0, 0, 800, 600);
			
			addChild(loadingScreen);
			
			//Load Localized file
			var url:URLRequest = new URLRequest("localize.xml");
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLocalizedLoaded);
			loader.load(url);
		}
		
		/**
		 * Handle end of localized file loading, cast to XML
		 * @param	e
		 */
		private function onLocalizedLoaded(e:Event):void
		{
			//Init XML global object
			Global.xml = new XML(e.target.data);
			
			//Remove loading Screen
			removeChild(loadingScreen);
			
			//TODO temp
			addChild(new BubbleSprite());
		}
		
	}
	
}