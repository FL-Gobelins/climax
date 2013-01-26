package 
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
		
		public function Node(predecessor:Node, content:Content):void {
			this.content = content;
			this.predecessor = predecessor;
			predecessor.AddSuccessor(this);
		}
		
		/**
		 *
		 * @param	successor
		 */
		private function AddSuccessor(successor:Node):void 
		{
			successors.push(successor);
		}
		
		/**
		 * Play any content
		 * @param	content
		 */
		protected function Play(content:Content):void
		{
			content.Play();
		}
	}
}