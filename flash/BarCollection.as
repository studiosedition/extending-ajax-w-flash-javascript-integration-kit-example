class BarCollection extends Array
{
	private static var instance:BarCollection = undefined;
	
	private function BarCollection()
	{
		super();
	}
	
	public static function get Instance():BarCollection
	{
		if(instance == undefined)
		{
			BarCollection.instance = new BarCollection();
		}
		return BarCollection.instance;
	}
	
}