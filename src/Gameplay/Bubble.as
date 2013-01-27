package Gameplay 
{
	import com.greensock.TweenMax;
	import Data.Node;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import org.osflash.signals.Signal;
	import com.greensock.plugins.*;
	
	
	/**
	 * ...
	 * @author Leonar Carpentier
	 */
	public class Bubble extends Sprite 
	{
		public var colorSwitched:Boolean = false;
		
		public var oncomingLine:BubbleLink;
		
		public var open:Boolean = false;
		
		public var scaledUp:Signal;
		public var scaledDown:Signal;
		
		private var mouseCurrentlyOver:Boolean = false;
		
		private var contentDisplay:Sprite = new Sprite();
		
		public var node:Node;
		
		private var openDisplay:OpenNode;
		private var closeDisplay:CloseNode;
		//TODO temp
		private var round:Sprite;
		
		public function Bubble(nodeParam:Node) 
		{
			node = nodeParam;
			
			scaledDown = new Signal();
			scaledUp = new Signal();
			
			TweenPlugin.activate([FramePlugin]);
			buttonMode = true;
			useHandCursor = true;
			mouseChildren = false;
			
			//round = new Sprite();
			//round.graphics.beginFill(0xFF0000);
			//round.graphics.drawCircle(0, 0, 40);
			
			openDisplay = new OpenNode();
			openDisplay.display.gotoAndStop(1);
			addChild(openDisplay);
			openDisplay.txt_label.text = node.getTitle();
			
			closeDisplay = new CloseNode();
			closeDisplay.gotoAndStop(1);
			addChild(closeDisplay);
			closeDisplay.visible = false;
			closeDisplay.txt_label.visible = false;
			
			//Add rotation
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			width = height = 120;
			
			//addChild(contentDisplay);
		}
		
		/**
		 * The bubble is being garbage collected.
		 * Clean here anything that could prevent it from being collected
		 */
		public function clean():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		public function displayContent():void
		{
			
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
			openDisplay.ring.visible = false;
			TweenMax.to(openDisplay.display, 0.7, { frame:openDisplay.display.totalFrames, onComplete:callbackScaleUp } );
			TweenMax.to(this, 0.7, { width:300, height:300 } );
			open = true;
		}
		
		public function scaleDown():void
		{
			hideContent();
			TweenMax.to(openDisplay.display, 0.7, { frame:1, onComplete:callbackScaleDown } );
			TweenMax.to(this, 0.7, { width:120, height:120 } );
			open = false;
		}
		
		private function callbackScaleUp():void
		{
			displayContent();
			openDisplay.txt_label.visible = false;
			scaledUp.dispatch();
		}
		
		private function callbackScaleDown():void
		{
			openDisplay.ring.visible = true;
			openDisplay.txt_label.visible = true;
			addChild(openDisplay.txt_label);
			//TODO Here
			scaledDown.dispatch();
		}
		
		/**
		 * Change orange to blue.
		 * This is a one way trip : don't even think of coming back.
		 * And don't look behind you either.
		 */
		public function switchColor():void
		{
			closeDisplay.visible = true;
			openDisplay.visible = false;
			
			if (open) 
			{
				closeDisplay.display.gotoAndStop(1);
				TweenMax.to(closeDisplay.display, 0.7, { frame:closeDisplay.display.totalFrames } );
				TweenMax.to(this, 0.7, { width:120, height:120 } );
			} else {
				closeDisplay.display.gotoAndStop(closeDisplay.display.totalFrames);
			}
			
			colorSwitched = true;
		}
		
		//-------------------------------------------------------------------------------
		//Event Manager
		//-------------------------------------------------------------------------------
		private function onEnterFrame(e:Event):void
		{
			//TODO : rotation
			if (openDisplay.parent && !mouseCurrentlyOver) 
			{
				openDisplay.ring.rotation += 1.5;
			}
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			mouseCurrentlyOver = true;
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			mouseCurrentlyOver = false;
		}
	}

}