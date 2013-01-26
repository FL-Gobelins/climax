package Data
{
	
	/**
	 * Load a tree from a XML file
	 * @author Franck Labat
	 */
	public class LoaderXML implements Loader 
	{
		private var nodes:Vector.<Node>; 
		
		public function LoaderXML(xml:XML):void 
		{
			nodes = new Vector.<Node>(xml.elements().length());
			var nodeXML:XML;
			// Load content
			for each(nodeXML in xml.elements())
			{
				var id:int = nodeXML.attribute("id");
				nodes[id] = new Node();
				var content:Content = ContentFactory.build(nodeXML.content.attribute("type"),
												           nodeXML.content.children()[0].toString());
				nodes[id].setContent(content);
			}
			
			// Load transitions
			for each(nodeXML in xml.elements())
			{
				var current:int = nodeXML.attribute("id");
				var predecessor:int = nodeXML.content.attribute("predecessor");
				
				nodes[current].addPredecessor(nodes[predecessor])
				nodes[predecessor].addSuccessor(nodes[current]);
			}
		}
		
		public function parent():Node
		{
			return nodes[0];
		}
	}
}