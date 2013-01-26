package Data
{
	import flash.text.engine.ContentElement;
	
	/**
	 * ...
	 * @author Franck labat
	 */
	public class Node
	{
		private var content:Content;
		private var predecessor:Node;
		private var successors:Vector.<Node>;
		private var id:int;
		
		public function Node() 
		{
		}
		
		public function setContent(content:Content):void {
			this.content = content;
		}
		
		public function getSuccessors():Vector.<Node>
		{
			return successors;
		}
		
		/**
		 *
		 * @param	successor
		 */
		public function addSuccessors(successor:Node):void 
		{
			successors.push(successor);
		}
		
		/**
		 * Play any content
		 * @param	content
		 */
		protected function Play(content:Content):void
		{
			content.play();
		}
	}
}