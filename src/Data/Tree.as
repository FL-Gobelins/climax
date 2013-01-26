package Data
{
	
	/**
	 * ...
	 * @author Franck Labat
	 */
	public class Tree
	{
		private var parent:Node = new Node();
		private var current:Node;
		private var loader:Loader;
		
		
		public function Tree(loader:Loader):void
		{
			this.loader = loader;
			//TODO: build tree with xml datas
			//build(parent);
			current = parent;
		}
		
		private function build():void
		{
			//TODO : Implement the build with DFS
			//BFS(parent, builder);
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