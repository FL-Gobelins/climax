package Data
{
	import Data.Node;
	import Data.Visitor;
	
	/**
	 * ...
	 * @author Franck Labat
	 */
	public class Printer implements Visitor
	{
		public function make(node:Node):void
		{
			trace(node);
		}
	}
	
}