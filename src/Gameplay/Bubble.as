package Gameplay 
{
	import com.greensock.TweenMax;
	import Data.Content;
	import Data.Dialog;
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
		private var dialog:DialogBox;
		private var imageDisplay:PictoBank;
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
			dialog = new DialogBox();
			dialog.x += dialog.width / 2;
			dialog.y += dialog.height / 2;
			dialog.visible = false;
			dialog.mouseEnabled = false;
			dialog.mouseEnabled = false;
			//addChild(dialog);
			closeDisplay.txt_label.visible = false;
			imageDisplay.gotoAndStop(1);
			
			//Add rotation
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			width = height = 180;
			
			//addChild(contentDisplay);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			
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
			
			if (dialog.parent) 
			{
				dialog.parent.removeChild(dialog);
			}
		}
		
		public function displayContent():void
		{
			//HANDLE TEXT
			var content:Content = node.getContent();
			if (content is Dialog)
			{
				if (parent) 
				{
					dialog.visible = true;
					parent.addChild(dialog);
					dialog.mouseEnabled = false;
					dialog.mouseChildren = false;
					dialog.x = x - dialog.width / 2;
					dialog.y = y - dialog.height / 2;
				}
			
				
				dialog.txt_dialog.text = (content as Dialog).toString();
				trace((content as Dialog).toString());
			}
			
			//HANDLE ContentImage
			if (content is ContentImage) 
			{
				if (parent) 
				{
					parent.addChild(imageDisplay);
					imageDisplay.x = x;
					imageDisplay.y = y;
					
					imageDisplay.gotoAndPlay((content as ContentImage).toString);
				}
			}
			
			
			//else if (content is ContentSound)
			//do stuff
			contentDisplay.mask = round;
		}
		
		public function hideContent():void
		{
			if (dialog.parent) 
			{
				dialog.parent.removeChild(dialog);
			}
			
			if (imageDisplay.parent) 
			{
				imageDisplay.parent.removeChild(imageDisplay);
			}
		}
		
		//-------------------------------------------------------------------------------
		//SCALING AREA
		//-------------------------------------------------------------------------------
		
		public function scaleUp():void
		{
			openDisplay.ring.visible = false;
			openDisplay.txt_label.visible = false;
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