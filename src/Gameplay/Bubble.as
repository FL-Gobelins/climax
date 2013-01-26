package Gameplay 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leonar Carpentier
	 */
	public class Bubble extends Sprite 
	{
		
		public function Bubble() 
		{
			var round:Sprite = new Sprite();
			round.graphics.beginFill(0xFF0000);
			round.graphics.drawCircle(0, 0, 40);
			
			addChild(round);
		}
		
	}

}