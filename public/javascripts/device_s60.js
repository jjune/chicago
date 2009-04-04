function init()
{

	document.getElementById("status").innerHTML = 'Getting location...';
}


function successCallback(position)
{
}

function errorCallback(err)
{

}

function getLocation()
{
	alert(1);
	var so = device.getServiceObject("Service.Location", "ILocation");
	alert(so);
	// This specifies update option used while retrieving location estimation. 
	var updateoptions = new Object();
	// Setting PartialUpdates to 'FALSE' ensures that user get atleast 
	// BasicLocationInformation (Longitude, Lattitude, and Altitude.)
	updateoptions.PartialUpdates = false;
	
	var criteria = new Object();
	criteria.LocationInformationClass = "GenericLocationInfo";
	criteria.Updateoptions = updateoptions;
	
	try
	{
		var result = so.ILocation.GetLocation(criteria);
		var location = result.ReturnValue
		return location;
	}
	catch (e)
	{
		document.getElementById("status").innerHTML = 'Error using Geolocation API: ' + e.message;
	}
}

function doLatLng()
{
	init();
	
	var location = getLocation();
	
    if(location.ErrorCode)
    {
    	document.getElementById("status").innerHTML = result.ReturnValue.ErrorCode;
	}
	else
	{
		document.getElementById("status").innerHTML = location.Latitude+" "+location.Longitude;
		document.getElementById("locationMap").src = "http://maps.google.com/staticmap?center="+position.latitude+","+position.longitude+"&zoom=14&size=<%=@device.screenwidth%>x128&maptype=mobile&markers="+position.latitude+","+position.longitude+",blue&format=png&sensor=false&key=<%=Ym4r::GmPlugin::ApiKey.get(:host=>request.host)%>";
	}

	return;
	
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