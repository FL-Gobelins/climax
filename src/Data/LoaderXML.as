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
			var id:int;
			// Load title and content
			for each(nodeXML in xml.elements())
			{
				id = nodeXML.attribute("id");
				nodes[id] = new Node();
				var title:String = nodeXML.title.children()[0].toString();
				var content:Content = ContentFactory.build(nodeXML.content.attribute("type"),
												           nodeXML.content.children()[0].toString());
				nodes[id].setContent(content);
				nodes[id].setTitle(title);
				nodes[id].id = id;
			}
			
			// Load transitions
			for each(nodeXML in xml.elements())
			{
				id = nodeXML.attribute("id");
				// id = 0 is the parent and doesn't have a parent
				if (id != 0)
				{
					var parent:int = nodeXML.attribute("parent");
					nodes[id].addPredecessor(nodes[parent])
					nodes[parent].addSuccessor(nodes[id]);
				}
			}
		}
		
		public function parent():Node
		{
			return nodes[0];
		}
	}
}