package 
{
	
	/**
	 * ...
	 * @author Franck Labat
	 */
	public class Tree
	{
		private var parent:Node;
		private var current:Node;
		private var loader:Loader;
		
		public function Tree(loader:Loader):void
		{
			this.loader = loader;
		}
		
		/**
		 * Implement breadth first search
		 */
		public function BFS(index:int):void
		{
			
		}
		
		public function getCurrent():Node
		{
			return current;
		}
	}
	
	/**
	 * FIFO container
	 */
	private class Queue {
		private var elements:Vector.<*> = [];
		
		function Queue():void
		{
		}
		
		function enqueue(element:*):void
		{
			elements = element;
		}
		
		function dequeue():*
		{
			if (isEmpty)dfzef
			
		}
		
		private function get isEmpty():Boolean
		{
			return elements.length <= 0;
		}
	}
}