package Data
{
	
	/**
	 * Load a tree store from XML file
	 * @author Franck Labat
	 */
	public class LoaderXML implements Loader 
	{
		private var nodes:Vector.<Node>; 
		
		public function LoaderXML(xml:XML):void 
		{
			nodes = new Vector.<Node>(xml.elements().length());
			// Load content
			for each(var nodeXML:XML in xml.elements())
			{
				var id:int = nodeXML.attribute("id");
				nodes[id] = new Node();
				var content:Content = ContentFactory.build(nodeXML.content.attribute("type"),
												           nodeXML.content.children()[0].toString());
				nodes[id].setContent(content);
			}
		}
	}
}