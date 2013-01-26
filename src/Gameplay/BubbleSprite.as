package Gameplay 
{
	import com.greensock.TweenMax;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Transform;
	import flash.sampler.NewObjectSample;
	
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
			bubble.scaleUp();
			currentBubble = bubble;
			addChild(bubble);
			
			bubble = new Bubble();
			bubble.x = 600;
			bubble.y = 100;
			bubbles.push(bubble);
			bubble.addEventListener(MouseEvent.CLICK, bubbleClicked);
			addChild(bubble);
		}
		
		//-----------------------------------------------------
		//Methods
		//-----------------------------------------------------
		
		/**
		 * Move the given bubble to the center of the screen and handl the dependencies
		 * @param	bubble
		 */
		private function moveBubbles(bubble:Bubble):void
		{
			//Add out-of-field bubbles -------------------------------------------------------------------------------------------------
			//TODO TEMP
			var amount:int = 3; // int(Math.random() * 5) + 1;//This should be equales to bubbleClicked.node.successors.length
			
			var spacer:int = Global.WIDTH / (amount + 1); //spacer between two new bubbles
			//we place a new bubble at each spacer
			for (var l:int = 0; l < amount; l++) 
			{
				//Create a bubble
				var newBubble:Bubble = new Bubble();
				//TODO : add a node to the bubble
				//place the bubble
				newBubble.x = bubble.x - (Global.WIDTH / 2) + ((l+1) * spacer);
				newBubble.y = bubble.y - 220;
				//Add it to the bubble vector
				bubbles.push(newBubble);
				//Add children
				addChild(newBubble);
				
				//create a line
				var line:BubbleLink = new BubbleLink(currentBubble.x, currentBubble.y, newBubble.x, newBubble.y);
				line.x = currentBubble.x;
				line.y = currentBubble.y;
				newBubble.oncomingLine = line;
				addChildAt(line, 0);
			}
			
			//If we are going down, unstore top-side bubbles
			//TODO
			
			//Defining the translation vector
			var destX:int = Global.WIDTH/2;
			var destY:int = Global.HEIGHT/2;
			var currentX:int = bubble.x;
			var currentY:int = bubble.y;
			var translateVector:Point = new Point(destX - currentX, destY - currentY);
			
			//Moving everything except for the current bubble
			for (var j:int = 0; j < bubbles.length; j++) 
			{
				if (bubbles[j].open){bubbles[j].scaleDown()};
				
				TweenMax.to(bubbles[j], 0.6, { x:bubbles[j].x + translateVector.x, y:bubbles[j].y + translateVector.y } );
				
				//If there is a line, handle it too
				if (bubbles[j].oncomingLine) TweenMax.to(bubbles[j].oncomingLine, 0.6, { x:bubbles[j].oncomingLine.x + translateVector.x, y:bubbles[j].oncomingLine.y + translateVector.y } );
			}
			
			//Move the currentBubble
			currentBubble.scaledUp.addOnce(contentDisplayed);
			currentBubble.scaleUp();
			TweenMax.to(currentBubble, 0.6, { x:currentBubble.x + translateVector.x, y:currentBubble.y + translateVector.y } );
			if (currentBubble.oncomingLine) TweenMax.to(currentBubble.oncomingLine, 0.6, { x:currentBubble.oncomingLine.x + translateVector.x, y:currentBubble.oncomingLine.y + translateVector.y } );
			
			//Clean bubbles
			cleanBubbles(bubble, amount);
		}
		
		/**
		 * Cleaning click listeners on the current stage
		 */
		private function disablingBubbles():void
		{
			//Disabling bubbles
			for (var i:int = 0; i < bubbles.length; i++) 
			{
				bubbles[i].removeEventListener(MouseEvent.CLICK, bubbleClicked);
			}
		}
		
		/**
		 * Cut unused Bubbles
		 * @param	bubble : the bubble clicked this round
		 * @param	newBubblesAmount : amount of bubbles created. Use to not destroy the new bubbles
		 */
		private function cleanBubbles(bubble:Bubble, newBubblesAmount:int):void
		{
			//Clean everything not stored and not added in the last move (that's the -newBubblesAmount thingy)
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
		
		//-----------------------------------------------------
		//Event listeners
		//-----------------------------------------------------
		
		/**
		 * Click handler for an active bubble
		 * @param	e
		 */
		private function bubbleClicked(e:MouseEvent):void
		{
			//Cleaning event listeners(clicks)
			disablingBubbles();
			
			if (!currentBubble.colorSwitched) 
			{
				currentBubble.switchColor();
			} else {
				currentBubble.scaleDown();
			}
			
			bubbles.splice(bubbles.indexOf((e.currentTarget as Bubble)), 1);	//pop the new bubble it out of the bubbles Vector
			bubbles.push(currentBubble); // Put former current bubble in bubbles
			currentBubble = (e.currentTarget as Bubble);//make it the currentBubble
			
			//Togle line color
			var ctransform:ColorTransform = new ColorTransform();
			ctransform.color = 0x248d9e;
			if (currentBubble.oncomingLine) 
			{
				currentBubble.oncomingLine.transform.colorTransform = ctransform;
			}
			
			(e.currentTarget as Bubble).stored = true; //Protect the path you selected
			moveBubbles((e.currentTarget as Bubble)); //Move camera
		}
		
		/**
		 * Click handler for the current  Bubble (toggling big/small)
		 * @param	e
		 */
		private function toggleCurrentBubble(e:MouseEvent):void
		{
			if (currentBubble.open) 
			{
				currentBubble.scaleDown();
			} else {
				currentBubble.scaleUp();
			}
		}
		
		//-----------------------------------------------------
		//Signal listeners
		//-----------------------------------------------------
		
		private function contentDisplayed():void
		{
			//At this point, content is displayed and movements are over
			//TODO add event on the current thing
			
			currentBubble.addEventListener(MouseEvent.CLICK, toggleCurrentBubble);
			
			//TODO add event on other //TODO : change 3 for currentbubble.node.successors 
			for (var i:int = 0; i < 3; i++) 
			{
				bubbles[bubbles.length - (i+1)].addEventListener(MouseEvent.CLICK, bubbleClicked);
			}
		}
	}

}