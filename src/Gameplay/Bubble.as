package Gameplay 
{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Leonar Carpentier
	 */
	public class Bubble extends Sprite 
	{
		
		public var stored:Boolean = false;
		public var oncomingLine:BubbleLink;
		
		public var open:Boolean = false;
		
		public var scaledUp:Signal;
		public var scaledDown:Signal;
		
		private var contentDisplay:Sprite = new Sprite();
		
		//TODO temp
		private var round:Sprite;
		
		public function Bubble() 
		{
			scaledDown = new Signal();
			scaledUp = new Signal();
			
			round = new Sprite();
			round.graphics.beginFill(0xFF0000);
			round.graphics.drawCircle(0, 0, 40);
			
			addChild(round);
			addChild(contentDisplay);
		}
		
		/**
		 * The bubble is being garbage collected.
		 * Clean here anything that could prevent it from being collected
		 */
		public function clean():void
		{
			
		}
		
		public function displayContent():void
		{
			//TODO : test
			var testAnim:JobJohn = new JobJohn();
			contentDisplay.addChild(testAnim);
			
			testAnim.stop();
			
			testAnim.width = 80;
			testAnim.height = 80;
			
			contentDisplay.mask = round;
		}
		
		public function hideContent():void
		{
			
		}
		
		//-------------------------------------------------------------------------------
		//SCALING AREA
		//-------------------------------------------------------------------------------
		
		public function scaleUp():void
		{
			//TweenMax.killAll(true, true, true);
			TweenMax.to(this, 0.6, { scaleX:4, scaleY:4, onComplete:callbackScaleUp } );
			open = true;
		}
		
		public function scaleDown():void
		{
			hideContent();
			//TweenMax.killAll(true, true, true);
			TweenMax.to(this, 0.4, { scaleX:1, scaleY:1, onComplete:callbackScaleDown } );
			open = false;
		}
		
		private function callbackScaleUp():void
		{
			displayContent();
			scaledUp.dispatch();
		}
		
		private function callbackScaleDown():void
		{
			scaledDown.dispatch();
		}
		
	}

}