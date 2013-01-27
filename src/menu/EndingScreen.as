package menu 
{
	import com.greensock.plugins.FramePlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import manager.EndingsManager;
	
	/**
	 * ...
	 * @author Leonar Carpentier
	 */
	public class EndingScreen extends Sprite 
	{
		
		public function EndingScreen() 
		{
			displayEndingsChoices();
		}
		
		private function displayEndingsChoices():void
		{
			var amount:int = EndingsManager.endings.length;
			var spacer:int = 800 / (amount + 1);
			
			for (var i:int = 0; i < amount; i++) 
			{
				var ending:ActionBackground = EndingsManager.endings[i];
				
				TweenMax.killAll(false);
				
				if (ending.parent) 
				{
					ending.parent.removeChild(ending);
				}
				
				ending.scaleX = ending.scaleY = 0.2;
				
				addChild(ending);
				ending.x = (i+1) * spacer-1/2*ending.width;
				ending.y = (600 - ending.height) / 2;
				
				ending.mouseEnabled = true;
				ending.mouseChildren = false;
				ending.buttonMode = true;
				ending.useHandCursor = true;
				
				ending.addEventListener(MouseEvent.CLICK, displayEndCinematic);
			}
			
		}
		
		private function displayEndCinematic(e:MouseEvent):void
		{
			var amount:int = EndingsManager.endings.length;
			
			for (var i:int = 0; i < amount; i++) 
			{
				var ending:ActionBackground = EndingsManager.endings[i];
				
				ending.scaleX = ending.scaleY = 0.2;
				
				if (ending.parent == this) 
				{
					removeChild(ending);
				}
				
				ending.mouseEnabled = false;
				ending.mouseChildren = false;
				
				ending.removeEventListener(MouseEvent.CLICK, displayEndCinematic);
			}
			
			var mc:MovieClip;
			
			switch (((e.currentTarget) as ActionBackground).txt_label.text) 
			{
				case "Talk elsewhere":
					mc = new ChangePlace();
				break;
				case "Tell the Truth":
					mc = new HateHer();
				break;
				case "Accept the break-up":
					mc = new Accept();
				break;
				case "Say you are sorry":
					mc = new Apologize();
				break;
				case "Run away":
					mc = new RunAway();
				break;
				default:
				case "Undergo the break-up":
					mc = new breakUp();
				break;
			}
			
			mc.x = 400;
			mc.y = 300;
			addChild(mc);
			TweenPlugin.activate([FramePlugin]);
			TweenMax.to(mc, mc.totalFrames, { frame:mc.totalFrames, useFrames:true } );
			//TODO : callback, the end
			
		}
		
	}

}