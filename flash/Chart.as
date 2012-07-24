import com.macromedia.javascript.JavaScriptProxy;
import com.macromedia.javascript.JavaScriptSerializer;
import BarCollection;
import Bar;

class Chart extends MovieClip
{
	private var proxy:JavaScriptProxy;
	private var barContainer:MovieClip;
	private var totalTxt:TextField;
	
	public function Chart()
	{
		super();
		this.totalTxt.autoSize = "right";
		this.proxy = new JavaScriptProxy(_root.lcId, this);
	}
	
	public function addItem(lender:String, rate:Number):Void
	{
		var tooltip = this.barContainer.attachMovie("tooltip", lender+"_tooltip", this.barContainer.getNextHighestDepth(), {_x: 500, _y: 0});
		
		var bCollection = BarCollection.Instance;
		var x = bCollection[(bCollection.length-1)]._x + bCollection[(bCollection.length-1)]._width+10;
		var bar = this.barContainer.attachMovie("bar", lender+"_bar", this.barContainer.getNextHighestDepth(), {_x: x, _y: 0});
		bar.setProperties(lender, rate, tooltip, (rate*20));
		bCollection.push(bar);
	
		this.totalTxt.text = "You are currently viewing "+ bCollection.length +" lenders.";
		
	}
	
	public function addAllItems(lenders:Array, rates:Array):Void
	{
		for(var i=0; i<lenders.length; i++)
		{
			this.addItem(lenders[i], rates[i]);
		}
	}
	
	public function proxyCall(_lender:String, color:String)
	{
		this.proxy.call("highlightItem", _lender, color, new Object());
	}
	
	public function highlightItem(lender:String):Void
	{
		var bCollection = BarCollection.Instance;
		for(var i in bCollection)
		{
			if(bCollection[i].lender == lender)
			{
				bCollection[i].highlightItem();
			}
		}
	}
	
}