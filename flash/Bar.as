class Bar extends Chart
{
	private var lender:String;
	private var rate:String;
	private var tooltip:MovieClip;
	private var color:MovieClip;
	private var shadow:MovieClip;
	private var active:Boolean = false;
	
	public function Bar()
	{
		super();
	}
	
	public function setProperties(_lender:String, _rate:String, _tooltip:MovieClip, h:Number):Void
	{
		this.lender = _lender;
		this.rate = _rate;
		this.tooltip = _tooltip;
		this._height = h;
	}
	
	private function onRollOver()
	{
		this.displayTooltip();
		this.highlightItem();
		super.proxyCall(this.lender, "#ebebeb");
	}
	
	private function onRollOut()
	{
		this.hideTooltip();
		this.highlightItem();
		super.proxyCall(this.lender, "#ffffff");
	}
	
	public function highlightItem()
	{
		var colorChanger:Color = new Color(this.color);
		var shadowChanger:Color = new Color(this.shadow);
		if(!this.active)
		{
			colorChanger.setRGB(0xebebeb);
			shadowChanger.setRGB(0xcccccc);
			this.active = true;
			this.displayTooltip();
		}
		else
		{
			colorChanger.setRGB(0xb1cbe4);
			shadowChanger.setRGB(0xebebeb);
			this.active = false;
			this.hideTooltip();
		}
	}
	
	private function displayTooltip()
	{
		this.tooltip.swapDepths(this._parent.getNextHighestDepth());
		this.tooltip._x = this._x+(this._width/2);
		this.tooltip._y = (this._y-this._height);
		this.tooltip.txt.htmlText = this.lender +"<br/>Rate: "+this.rate;
	}
	
	private function hideTooltip()
	{
		this.tooltip._x = 500;
		this.tooltip._y = 0;
		this.tooltip.txt.htmlText = "";
	}
	
}