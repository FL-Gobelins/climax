package Data
{
	import flash.text.engine.ContentElement;
	import Gameplay.Bubble;
	
	/**
	 * ...
	 * @author Franck labat
	 */
	public class Node
	{
		public var id:int;
		private var content:Content;
		private var title:String;
		private var predecessor:Node;
		private var successors:Vector.<Node> = new Vector.<Node>();
		
		public var bubble:Bubble;
		
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
		public function addSuccessor(successor:Node):void 
		{
			successors.push(successor);
		}
		
		private var _visited:Boolean = false;
		
		/**
		 * 
		 * @param	predecessor
		 */
		public function addPredecessor(predecessor:Node):void 
		{
			this.predecessor = predecessor;
		}
		
		/**
		 * Play any content
		 * @param	content
		 */
		protected function Play(content:Content):void
		{
			content.play();
		}
		
		public function setTitle(title:String):void
		{
			this.title = title;
		}
		
		public function getTitle():String
		{
			return title;
		}
		
		
		public function toString():String
		{
			//TODO: print the content after finishing content classes 
			return id + title + " ";// + content.toString() + " ";
		}
		
		public function get visited():Boolean 
		{
			return _visited;
		}
		
		public function set visited(value:Boolean):void 
		{
			_visited = value;
		}
	}
}