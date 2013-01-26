package Gameplay 
{
	import com.greensock.TweenMax;
	import com.greensock.TweenMax;
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
		public var currentBubble:Bubble;
		
		public function BubbleSprite() 
		{
			//TODO : place holders
			var bubble:Bubble = new Bubble();
			bubble.x = 400;
			bubble.y = 300;
			bubble.stored = true;
			bubbles.push(bubble);
			currentBubble = bubble;
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
			(e.currentTarget as Bubble).stored = true; //Protect the path you selected
			currentBubble = (e.currentTarget as Bubble);//make it the currentBubble
			moveBubbles((e.currentTarget as Bubble)); //Move camera
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
			//TODO TEMP
			var amount:int = int(Math.random()*5)+1;//This should be equales to bubbleClicked.node.successors.length
			
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
			
			//If we are going down, unstore top-side bubbles
			//TODO
			
			//Defining the translation vector
			var destX:int = Global.WIDTH/2;
			var destY:int = Global.HEIGHT/2;
			var currentX:int = bubble.x;
			var currentY:int = bubble.y;
			var translateVector:Point = new Point(destX - currentX, destY - currentY);
			
			//Moving everything
			for (var j:int = 0; j < bubbles.length; j++) 
			{
				//If this is the currentBubble, add a specific callback about size
				if (bubbles[j] == currentBubble) 
				{
					 TweenMax.to(bubbles[j], 0.6, { x:bubbles[j].x + translateVector.x, y:bubbles[j].y + translateVector.y, scaleX:2, scaleY:2, onComplete:displayBubbleContent, onCompleteParams:[bubble] } );
				} else {
					TweenMax.to(bubbles[j], 0.6, { x:bubbles[j].x + translateVector.x, y:bubbles[j].y + translateVector.y } );
				}
				
				
				if (bubbles[j].oncomingLine) 
				{
					TweenMax.to(bubbles[j].oncomingLine, 0.6, { x:bubbles[j].oncomingLine.x + translateVector.x, y:bubbles[j].oncomingLine.y + translateVector.y } );
				}
			}
			
			//Enabling clickable bubbles
			for (var m:int = 0; m < amount; m++) 
			{
				//Enabling top-side bubbles
				(bubbles[bubbles.length - (1 + m)] as Bubble).addEventListener(MouseEvent.CLICK, bubbleClicked);
			}
			bubble.addEventListener(MouseEvent.CLICK, bubbleClicked); //Enabling going back //TODO : get bubble trhough bubble.node.previous
			
			
			//Clean bubbles
			cleanBubbles(bubble, amount);
			
		}
		
		/**
		 * Cut unused Bubbles
		 * @param	bubble : the bubble clicked this round
		 * @param	newBubblesAmount : amount of bubbles created. Use to not destroy the new bubbles
		 */
		private function cleanBubbles(bubble:Bubble, newBubblesAmount:int):void
		{
			//Clean everything not stored
			for (var i:int = 0; i < (bubbles.length - newBubblesAmount); i++) 
			{
				if (!bubbles[i].stored ) 
				{
					//If bubble is not stored, it is either on a unused branch or geting out of the screen by the top
					//TODO : tweenout bubble
					TweenMax.to(bubbles[i], 0.2, { alpha:0 });//, onComplete:garbageCollectBubble, onCompleteParams:[bubble[i]] } );
					//TODO : fade out bubble.line if bubble.line
					if (bubbles[i].oncomingLine) 
					{
						TweenMax.to(bubbles[i].oncomingLine, 0.2, { alpha:0} );
					}
				}
			}
		}
		
		/**
		 * Handle memory on the unused bubbles
		 * @param	bubble
		 */
		private function garbageCollectBubble(bubble:Bubble):void
		{
			removeChild(bubble);
			bubbles.splice(bubbles.indexOf(bubble), 1);
			if (bubble.oncomingLine) 
			{
				removeChild(bubble.oncomingLine);
			}
			bubble.clean();
		}
		
		/**
		 * 
		 * @param	bubble
		 */
		private function displayBubbleContent(bubble:Bubble):void
		{
			
		}
		
		
	}

}