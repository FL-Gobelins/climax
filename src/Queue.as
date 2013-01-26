package 
{
	
	/**
	 * ...
	 * @author Franck labat
	 */
	public class Queue 
	{
		private var elements:Array = [];
		
		function Queue():void
		{
		}
		
		public function enqueue(element:*):void
		{
			elements[elements.length] = element;
			length++;
		}
		
		public function dequeue():*
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
	}
	
}