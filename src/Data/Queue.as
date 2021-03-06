package Data
{
	
	/**
	 * ...
	 * @author Franck labat
	 */
	public class Queue 
	{
		private var elements:Array = [];
		private var length:int = 0;
		
		function Queue():void
		{
		}
		
		public function enqueue(element:Node):void
		{
			elements[elements.length] = element;
			length++;
		}
		
		public function dequeue():Node
		{
			if (isEmpty) 
			{
				return null;
			}
			else
			{
				length--;
				return elements.shift();
			}
		}
		
		public function get isEmpty():Boolean
		{
			return elements.length <= 0;
		}
		
		public function contain(node:Node):Boolean
		{
			for each(var element:Node in elements)
			{
				if (element == node)
					return true;
			}
			
			return false;
		}
	}
	
}