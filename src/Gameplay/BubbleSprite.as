package Gameplay 
{
	import com.greensock.TweenMax;
	import com.greensock.TweenMax;
	import Data.Node;
	import Data.Tree;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Transform;
	import flash.sampler.NewObjectSample;
	import manager.SoundManager;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Leonar Carpentier
	 */
	public class BubbleSprite extends Sprite 
	{
		
		public var bubbles:Vector.<Bubble> = new Vector.<Bubble>();
		public var currentBubble:Bubble;
		public var requestHeartbeat:Signal;
		
		private var count:int = 0;
		
		private var localScenario:Tree;
		private var firstClicked:Boolean = true;
		private var bg:GameplayBackground = new GameplayBackground();
		
		public function BubbleSprite(scenario:Tree) 
		{
			localScenario = scenario;
			
			bg.vignet.visible = false;
			
			addChild(bg);
			
			requestHeartbeat = new Signal();
			
			var bubble:Bubble = new Bubble(scenario.getCurrent());
			scenario.getCurrent().bubble = bubble;
			bubble.x = 400;
			bubble.y = 300;
			bubbles.push(bubble);
			//currentBubble = bubble;
			bubble.addEventListener(MouseEvent.CLICK, bubbleClicked);
			addChild(bubble);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//-----------------------------------------------------
		//Methods
		//-----------------------------------------------------
		
		private function init(e:Event = null):void
		{
			SoundManager.getInstance().launchMainMusic();
		}
		
		/**
		 * Move the given bubble to the center of the screen and handl the dependencies
		 * @param	bubble
		 */
		private function moveBubbles(bubble:Bubble):void
		{
			//Add out-of-field bubbles -------------------------------------------------------------------------------------------------
			//TODO TEMP
			var amount:int = localScenario.getCurrent().getSuccessors().length;//3; // int(Math.random() * 5) + 1;//This should be equales to bubbleClicked.node.successors.length
			
			var spacer:int = Global.WIDTH / (amount + 1); //spacer between two new bubbles
			//we place a new bubble at each spacer
			//for (var l:int = 0; l < amount; l++) 
			var l:int = 1;
			for each (var successor:Node in localScenario.getCurrent().getSuccessors())
			{
				//var localNode:Node = localScenario.getCurrent().getSuccessors()[l];
				
				//Create a bubble
				if (!successor.bubble) 
				{
					var newBubble:Bubble = new Bubble(successor);
					if (successor.visited) 
					{
						newBubble.switchColor();
					}
					
					
					successor.bubble = newBubble;
					//TODO : add a node to the bubble
					//place the bubble
					newBubble.x = bubble.x - (Global.WIDTH / 2) + (l * spacer);
					newBubble.y = bubble.y - 220;
					//Add it to the bubble vector
					bubbles.push(newBubble);
					//Add children
					addChild(newBubble);
					
					//create a line
					var line:BubbleLink;
					
					if (successor.visited) 
					{
						newBubble.switchColor();
						line = new BubbleLink(currentBubble.x, currentBubble.y, newBubble.x, newBubble.y, true);
					} else {
						line = new BubbleLink(currentBubble.x, currentBubble.y, newBubble.x, newBubble.y);

					}
					
					line.x = currentBubble.x;
					line.y = currentBubble.y;
					newBubble.oncomingLine = line;
					addChildAt(line, 0);
				}
				l++;
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
			//Disable Toggle
			if (currentBubble) 
			{
				currentBubble.removeEventListener(MouseEvent.CLICK, toggleCurrentBubble);
			}
			
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
		private function cleanBubbles(mainBubble:Bubble, amount:int):void
		{
			//trace("------------------cleaning-------------");
			//Clean everything not stored and not added in the last move (that's the -newBubblesAmount thingy)
			//for (var i:int = 0; i < (bubbles.length - amount); i++)
			for each(var bubble:Bubble in bubbles)
			{
				//if(!localScenario.isInMainPath(bubble.node))
				//var bool1:Boolean = localScenario.getCurrent().near(bubble.node);
				//var bool2:Boolean = localScenario.isInMainPath(bubble.node);
				//trace(bubble.node.getTitle() + " " + bool1 + " " + bool2);
				
				
				if (!localScenario.getCurrent().near(bubble.node) && !localScenario.isInMainPath(bubble.node))
				{
					//If bubble is not stored, it is either on a unused branch or geting out of the screen by the top
					//TODO : tweenout bubble
					TweenMax.to(bubble, 0.2, { alpha:0}); //, onComplete:garbageCollectBubble, onCompleteParams:[bubble[i]] } );
					//TODO : fade out bubble.line if bubble.line
					if (bubble.oncomingLine) 
					{
						TweenMax.to(bubble.oncomingLine, 0.2, { alpha:0} );
					}
					//bubbles.splice(bubbles.indexOf(bubble), 1);
					bubble.node.bubble = null;
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
			
			if (firstClicked) 
			{
				firstClicked = false;
			} else {
				requestHeartbeat.dispatch();
				SoundManager.getInstance().boomBoom();
				count++;
				bg.vignet.visible = true;
				bg.vignet.alpha = Math.min(count, 12) / 12;
				TweenMax.delayedCall(0.2, function():void {
					TweenMax.to(bg.vignet, count / 20 + 0.1, { alpha: (count/12) * 0.3 + 0.1 } );
				});
			}
			
			if (currentBubble) 
			{
				if (!currentBubble.colorSwitched) 
			{
					currentBubble.switchColor();
				} else {
					currentBubble.scaleDown();
				}
				
				if ((e.currentTarget as Bubble).node == currentBubble.node.getPredecessor())
				{
					localScenario.previous();
				} else {
					localScenario.next(((e.currentTarget) as Bubble).node.id);
				}
				
				bubbles.splice(bubbles.indexOf((e.currentTarget as Bubble)), 1);	//pop the new bubble it out of the bubbles Vector
				bubbles.push(currentBubble); // Put former current bubble in bubbles
			}
			
			
			
			
			
			currentBubble = (e.currentTarget as Bubble);//make it the currentBubble
			
			//Togle line color
			var ctransform:ColorTransform = new ColorTransform();
			ctransform.color = 0x248d9e;
			if (currentBubble.oncomingLine) 
			{
				currentBubble.oncomingLine.transform.colorTransform = ctransform;
			}
			
			(e.currentTarget as Bubble).node.visited = true; //Protect the path you selected
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
			// add event on the current thing
			
			currentBubble.addEventListener(MouseEvent.CLICK, toggleCurrentBubble);
			
			//TODO : change 3 for currentbubble.node.successors 
			for each(var successor:Node in currentBubble.node.getSuccessors())
			{
				successor.bubble.addEventListener(MouseEvent.CLICK, bubbleClicked);
			}
			
			
			//TODO add Event Listener on the previous node
			var predecessor:Node = currentBubble.node.getPredecessor();
			if (predecessor) 
			{
				predecessor.bubble.addEventListener(MouseEvent.CLICK, bubbleClicked);
			}
			
		}
	}

}