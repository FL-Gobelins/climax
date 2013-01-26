package Data
{
	
	/**
	 * Tree that store typicaly a scenario
	 * @author Franck Labat
	 */
	public class Tree
	{
		private var start:Node = new Node();
		private var current:Node;
		private var loader:Loader;
		
		
		public function Tree(loader:Loader):void
		{
			this.loader = loader;
			start = current = loader.parent();
			var printer:Printer = new Printer();
			//BFS(start, printer);
			//DFS(start, printer);
		}
		
		/**
		 * Implement breadth first search
		 */
		public function BFS(start:Node, visitor:Visitor):void
		{
			var queue:Queue = new Queue();
			queue.enqueue(start);
			while (!queue.isEmpty)
			{
				var t:Node = queue.dequeue();
				visitor.make(t);
				for each(var u:Node in t.getSuccessors())
					queue.enqueue(u);
			}
		}
		
		public function DFS(node:Node, visitor:Visitor):void 
		{
			visitor.make(node);
			for each(var successor:Node in node.getSuccessors())
				DFS(successor, visitor);
		}
		
		public function getCurrent():Node
		{
			return current;
		}
	}
}

