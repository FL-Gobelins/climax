package manager {
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	/**
	 * ...
	 * @author www.leonard-carpentier.com
	 */
	public class SoundManager {
	
		//{ region Class constants
		
		//} endregion
		
		//{ region Constructor
		
		/**
		* Return the unique instance of the class
		*/
		public static function getInstance():SoundManager {
			if (instance == null) {
				localCall = true;
				instance = new SoundManager();
				localCall = false;
			}
			return instance;
		}
		
		/**
		* CONSTRUCTOR This class is a Singleton, use getInstance()
		*/
		public function SoundManager ():void {
			if (!localCall) {
				throw new Error("Error: Instantiation not allowed : Use SoundManager.getInstance() instead of new.");
			} else {
				
			}
		}
		
		//} endregion
		
		//{ region Variables
		
		/* Auto Déclaration */
		private static var instance:SoundManager;
		private static var localCall:Boolean;
		
		private var titleSoundChannel:SoundChannel;
		private var soundtrackSoundChannel:SoundChannel;
		
		//} endregion
		
		//{ region Properties
		
		public var musicPlaying:Boolean = false;
		
		//} endregion
		
		//{ region Methods
		
		//-----------------------------------------
		// Public
		//-----------------------------------------
		
		/**
		 * Destroy Singleton instance
		 */
		public static function kill():void {
			instance = null;
		}
		
		//SOUNDS
			
		public function launchTitleMusic():void
		{
			var c:Class;
			c = TitleSoundtrack;
			var snd:Sound = new c();
			titleSoundChannel = snd.play(0, 500, new SoundTransform(0.5));
		}
		
		public function set titleVolume(volume:Number):void
		{
			if (titleSoundChannel) 
			{
				titleSoundChannel.soundTransform = new SoundTransform(volume);
			}
		}
		
		public function get titleVolume():Number
		{
			if (titleSoundChannel) 
			{
				return titleSoundChannel.soundTransform.volume;
			} else {
				return 0;
			}
		}
		
		public function launchMainMusic():void
		{
			var c:Class;
			c = MainSoundtrack;
			var snd:Sound = new c();
			soundtrackSoundChannel = snd.play(0, 500, new SoundTransform(0.5));
		}
		
		public function set mainVolume(volume:Number):void
		{
			if (soundtrackSoundChannel) 
			{
				soundtrackSoundChannel.soundTransform = new SoundTransform(volume);
			}
		}
		
		public function get mainVolume():Number
		{
			if (soundtrackSoundChannel) 
			{
				return soundtrackSoundChannel.soundTransform.volume;
			} else {
				return 0;
			}
		}
		
		public function boomBoom():void
		{
			var c:Class;
			c = BoomBoom;
			var snd:Sound = new c();
			var sc:SoundChannel = snd.play();
		}
		
		
		//-----------------------------------------
		// Private
		//-----------------------------------------
		
		//} endregion
		
		//{ region Signals handlers
		
		//} endregion
		
		//{ region Event listeners
		
		
		//} endregion
	}
}