var xmlhttp;
function createXMLHttpRequest(url) 
{
	if (window.XMLHttpRequest) // XMLHttpRequest object
	{
		xmlhttp = new XMLHttpRequest();
		loadXML(url);
	}
	else if (window.ActiveXObject) // IE/Windows ActiveX version
	{
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		loadXML(url);
	}
}

function loadXML(url)
{
	xmlhttp.onreadystatechange = processReqChange;
	xmlhttp.open("GET", url, true);
	xmlhttp.send(null);
}

function processReqChange() 
{
	if (xmlhttp.readyState == 4)
	{
		if (xmlhttp.status == 200)
		{
			nodes = xmlhttp.responseXML.documentElement.childNodes;
			response = xmlhttp.responseXML.documentElement;
			names = new Array();
			rates = new Array();
			for(var i=0; i<nodes.length; i++)
			{
				// Firefox: address the issue with nodes.length
				if(navigator.appName == "Netscape")
				{
					if(response.getElementsByTagName('lender')[i] == undefined)
					{
						// Firefox: address the jfik issue with sequential calls by passing arrays
						flashProxy.call('addAllItems', names, rates);
					}
				}
				
				var name = response.getElementsByTagName('lender')[i].getAttribute('name');
				names.push(name);
				var rate = response.getElementsByTagName('rate')[i].firstChild.data;
				rates.push(rate);
				var payment = response.getElementsByTagName('payment')[i].firstChild.data;
				var origination = response.getElementsByTagName('origination')[i].firstChild.data;
				document.getElementById('content').innerHTML += "<br/>"+
																"<div id='"+ name +"'>"+
																"<span class='title'>"+ name +"</span>"+
																"&nbsp;<a href=\"#\""+
																"onmouseover=\"javascript:flashProxy.call('highlightItem', '"+ name +"');highlightItem('"+ name +"', '#ebebeb');\""+
																"onmouseout=\"javascript:flashProxy.call('highlightItem', '"+ name +"');highlightItem('"+ name +"', '#ffffff');\""+
																">Chart</a>"+
																"<hr>"+
																"<b>Rate:</b> <span class='main'>"+ rate +"</span>"+
																"<b>Payment:</b> <span class='main'>"+ payment +"</span>"+
																"<b>Origination:</b> <span class='main'>"+ origination +"</span>"
																"</div>";
			}
			// IE: address the jfik issue with sequential calls by passing arrays
			flashProxy.call('addAllItems', names, rates);
		}
		else
		{
			alert("There was a problem receiving the XML data:\n" + xmlhttp.statusText);
		}
	}
}