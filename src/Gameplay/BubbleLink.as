package Gameplay 
{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Leonar Carpentier
	 */
	public class BubbleLink extends Sprite 
	{
		
		public function BubbleLink(originX:int, originY:int, targetX:int, targetY:int, blue:Boolean = false) 
		{
			if (blue) 
			{
				graphics.lineStyle(3,0x248d9e);
			} else 
			{
				graphics.lineStyle(3,0xf29127);
			}
			
			graphics.lineTo(targetX - originX, targetY - originY);
			graphics.endFill();
			alpha = 0;
			TweenMax.to(this, 1, { alpha:1 } );
		}
		
	}

}