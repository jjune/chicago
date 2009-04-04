document.write("<script language='Javascript' src='/javascripts/gears_init.js' ></script>");	
function init()
{
	// Make sure we have Gears. If not, tell the user.
	if (!window.google || !google.gears)
	{
		if (confirm("This application requires Gears to be installed. Install now?"))
		{
			// Use an absolute URL to allow this to work when run from a local file.
			location.href = "http://code.google.com/apis/gears/install.html";
			return;
		}
	}
	
	document.getElementById("status").innerHTML = 'Getting location...';
}


function successCallback(position)
{
	var address = 
	position.gearsAddress.streetNumber + ' '
	+ position.gearsAddress.street + ','
	+ position.gearsAddress.city + ', '
	+ position.gearsAddress.region + ', '
	+ position.gearsAddress.country + ' ('
	+ position.latitude + ', '
	+ position.longitude + ')';
	
	document.getElementById("status").innerHTML = address;
	document.getElementById("locationMap").src = "http://maps.google.com/staticmap?center="+position.latitude+","+position.longitude+"&zoom=14&size=<%=@device.screenwidth%>x128&maptype=mobile&markers="+position.latitude+","+position.longitude+",blue&format=png&sensor=false&key=<%=Ym4r::GmPlugin::ApiKey.get(:host=>request.host)%>";
}

function errorCallback(err)
{
	document.getElementById("status").innerHTML = 'Error retrieving your location: ' + err.message;
}

function doLatLng()
{
	try 
	{
		init();
		var geolocation = google.gears.factory.create('beta.geolocation');
		geolocation.getCurrentPosition(successCallback,errorCallback,{enableHighAccuracy: true,gearsRequestAddress: true });
	}
	catch (e) 
	{
		document.getElementById("status").innerHTML = 'Error using Geolocation API: ' + e.message;
		return;
	}
}

function doSubmit(action)
{
	document.getElementById("queryForm").action = "/where/"+action;
	document.getElementById("status").innerHTML = action+"ing..."
	var geolocation = google.gears.factory.create('beta.geolocation');
	geolocation.getCurrentPosition(postCallbackSubmit,errorCallback,{enableHighAccuracy: true,gearsRequestAddress: true });
}

function postCallbackSubmit(position)
{
	action="snoop";
	location.href="/where/"+action+"?lat="+position.latitude+"&lng="+position.longitude;
	//document.queryForm.lat.value = position.latitude;
	//document.queryForm.lng.value = position.longitude;
	//document.getElementById("queryForm").submit();
}