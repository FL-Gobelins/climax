package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import Gameplay.BubbleSprite;
	import Data.*;
	import menu.TitleScreen;
	import com.greensock.TweenMax;
	
	/**
	 * ...
	 * @author Leonar Carpentier
	 */
	public class Main extends Sprite 
	{
		private var loader:Loader;
		private var scenario:Tree;
		private var bubbleSprite:BubbleSprite;
		private var titleScreen:TitleScreen;
		
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
			var url:URLRequest = new URLRequest("LevelTest.xml");
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onLocalizedLoaded);
			urlLoader.load(url);
		}
		
		/**
		 * Handle end of localized file loading, cast to XML
		 * @param	e
		 */
		private function onLocalizedLoaded(e:Event):void
		{
			//Init XML global object
			//Global.xml = new XML(e.target.data);
			
			loader = new LoaderXML(new XML(e.target.data));
			scenario = new Tree(loader);
			bubbleSprite = new BubbleSprite(scenario);
			titleScreen = new TitleScreen();
			
			titleScreen.requestLaunchGame.addOnce(launchGameRequested);
			
			//Remove loading Screen
			removeChild(loadingScreen);
			
			//TODO temp
			addChild(titleScreen);
		}
		
		private function launchGameRequested():void 
		{
			addChild(bubbleSprite);
			TweenMax.to(titleScreen, 3, { y:titleScreen.y + 500, onComplete:cleanTitleScreen } );
		}
		
		private function cleanTitleScreen():void
		{
			
		}
	}
	
}