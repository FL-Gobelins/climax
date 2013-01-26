package Gameplay 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leonar Carpentier
	 */
	public class Bubble extends Sprite 
	{
		
		public var stored:Boolean = false;
		public var oncomingLine:BubbleLink;
		
		public function Bubble() 
		{
			var round:Sprite = new Sprite();
			round.graphics.beginFill(0xFF0000);
			round.graphics.drawCircle(0, 0, 40);
			
			addChild(round);
		}
		
		/**
		 * The bubble is being garbage collected.
		 * Clean here anything that could prevent it from being collected
		 */
		public function clean():void
		{
			
		}
		
	}

}