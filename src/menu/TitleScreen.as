package menu 
{
	import com.greensock.plugins.FramePlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Gameplay.BubbleSprite;
	
	/**
	 * ...
	 * @author Leonar Carpentier
	 */
	public class TitleScreen extends Sprite 
	{
		
		private var display:IntroScreenAsset = new IntroScreenAsset();
		private var introZoomedIn:Boolean = false;
		
		public function TitleScreen() 
		{
			TweenPlugin.activate([FramePlugin]);
			
			TweenMax.to(display.clip, 32, { useFrames:true, frame:16, repeat:-1} );
			
			addChild(display);
			
			display.playButton.buttonMode = true;
			display.playButton.useHandCursor = true;
			display.playButton.mouseChildren = false;
			display.playButton.addEventListener(MouseEvent.CLICK, launchIntro);
		}
		
		private function launchIntro(e:MouseEvent):void
		{
			display.playButton.removeEventListener(MouseEvent.CLICK, launchIntro);
			TweenMax.to(display.playButton, 0.3, { alpha:0, onComplete:destroyPlayButton } );
			
			TweenMax.killTweensOf(display.clip);
			display.clip.play();
			display.clip.addEventListener(Event.ENTER_FRAME, onClipEnterFrame);
			
			TweenMax.to(display.clip, 0.7, { y:display.clip.y+120 } );
			TweenMax.to(display.logo, 0.7, { y:display.logo.y+120 } );
		}
		
		private function destroyPlayButton():void
		{
			display.playButton.visible = false;
		}
		
		private function onClipEnterFrame(e:Event):void
		{
			if (display.clip.currentFrame >=180 && !introZoomedIn) 
			{
				//Toggle a flag
				introZoomedIn = true;
				//Zoom in
				TweenMax.to(display.clip, 2.5, { scaleX:7, scaleY:7, y:display.clip.y + 450, x:display.clip.x + 400 } );
			}
			if (display.clip.currentFrame >= 219)
			{
				display.clip.removeEventListener(Event.ENTER_FRAME, onClipEnterFrame);
				display.clip.stop();
				//unzoom and scroll up
				TweenMax.killTweensOf(display.clip);
				TweenMax.to(display.clip, 1, { scaleX:4, scaleY:4, y:display.clip.y, x:display.clip.x-60 } );
				//Need a bubbleSprite
				//Signal ?
			}
		}
		
	}

}