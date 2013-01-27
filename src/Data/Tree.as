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
		private var path:Vector.<Node> = new Vector.<Node>;
		
		public function Tree(loader:Loader):void
		{
			this.loader = loader;
			start = current = loader.parent();
			start.visited = true;
			var printer:Printer = new Printer();
			path.push(start);
			// Print the tree
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
		
		public function next(id:int):void
		{
			if (id == 0)
				return;
			
			for each(var node:Node in getCurrent().getSuccessors())
			{
				if (node.id == id)
				{
					current = node;
					current.visited = true;
					path.push(current);
					return;
				}
			}
			
			throw new Error("Stop to hack this game!!!");
		}
		
		public function previous():void
		{
			if (current.id != 0)
			{
				current = current.getPredecessor();
				path.pop();
			}
		}
		
		public function isInMainPath(node:Node):Boolean
		{
				for each(var element:Node in path)
				{
					if (element == node)
						return true;
				}
				
				return false;
		}
	}
}

