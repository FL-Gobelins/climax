package Data 
{
	/**
	 * ...
	 * @author Franck Labat
	 */
	public class Builder implements Visitor 
	{
		
		private var loader:Loader;
	
		public function Builder(loader:Loader)
		{
			this.loader = loader;
		}
	
		public function make(current:Node):void
		{
			//for (var i:int = 0; i; i++)
			//{
				//current.addSuccessors(new Node());
			//}
		}
		
	}
}