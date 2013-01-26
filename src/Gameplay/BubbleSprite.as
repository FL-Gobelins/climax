package Gameplay 
{
	import com.greensock.TweenNano;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Leonar Carpentier
	 */
	public class BubbleSprite extends Sprite 
	{
		
		public var bubbles:Vector.<Bubble> = new Vector.<Bubble>();
		public var lines:Vector.<Sprite> = new Vector.<Sprite>();
		
		public function BubbleSprite() 
		{
			var bubble:Bubble = new Bubble();
			bubble.x = 400;
			bubble.y = 300;
			bubbles.push(bubble);
			addChild(bubble);
			
			bubble = new Bubble();
			bubble.x = 600;
			bubble.y = 100;
			bubbles.push(bubble);
			bubble.addEventListener(MouseEvent.CLICK, bubbleClicked);
			addChild(bubble);
		}
		
		/**
		 * Click handler for an active bubble clicked
		 * @param	e
		 */
		private function bubbleClicked(e:MouseEvent):void
		{
			moveBubbles((e.currentTarget as Bubble));
		}
		
		/**
		 * Move the given bubble to the center of the screen and handl the dependencies
		 * @param	bubble
		 */
		private function moveBubbles(bubble:Bubble):void
		{
			//Disabling bubbles
			for (var i:int = 0; i < bubbles.length; i++) 
			{
				bubbles[i].removeEventListener(MouseEvent.CLICK, bubbleClicked);
			}
			
			//Add out-of-field bubbles
			//TEMP
			var amount:int = int(Math.random()*4)+1;//This should be equales to bubbleClicked.node.successors.length
			
			var spacer:int = Global.WIDTH / (amount + 1); //spacer between two new bubbles
			//we place a new bubble at each spacer
			for (var l:int = 0; l < amount; l++) 
			{
				//Create a bubble
				var newBubble:Bubble = new Bubble();
				//TODO : add a node to the bubble
				//place the bubble
				newBubble.x = bubble.x - (Global.WIDTH / 2) + ((l+1) * spacer);
				newBubble.y = bubble.y - 200;
				//Add it to the bubble vector
				bubbles.push(newBubble);
				//Add children
				addChild(newBubble);
			}
			
			
			
			
			//Defining the translation vector
			var destX:int = Global.WIDTH/2;
			var destY:int = Global.HEIGHT/2;
			var currentX:int = bubble.x;
			var currentY:int = bubble.y;
			var translateVector:Point = new Point(destX - currentX, destY - currentY);
			
			//Moving everything
			for (var j:int = 0; j < bubbles.length; j++) 
			{
				TweenNano.to(bubbles[j], 0.6, { x:bubbles[j].x+translateVector.x, y:bubbles[j].y+translateVector.y } );
			}
			
			for (var k:int = 0; k < lines.length; k++) 
			{
				TweenNano.to(lines[k], 0.6, { x:lines[k].x+translateVector.x, y:lines[k].y+translateVector.y } );
			}
			
			//Enabling clickable bubbles
			for (var m:int = 0; m < amount; m++) 
			{
				(bubbles[bubbles.length - (1 + m)] as Bubble).addEventListener(MouseEvent.CLICK, bubbleClicked);
			}
			
		}
		
		
		
	}

}