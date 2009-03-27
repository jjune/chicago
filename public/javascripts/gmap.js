//Initialize a lat lng from a user's IP to decide where to start the map
document.write("<script language='Javascript' src='http://gd.geobytes.com/gd?after=-1&variables=GeobytesCountry,GeobytesCity,GeobytesRegion,GeobytesLatitude,GeobytesLongitude' ></script>");

var map = null;
var prizearea = null;
var gLargeMapControl=null;

function doStuffBeforeSubmit()
{
	$("prize_prizearea").value = gPolygonToJSON(prizearea);
	$("zoom").value = map.getZoom();
}

function gPolygonToJSON(polygon)
{
	var arrPointsJSON = new Array();
	for (var x=0;x<polygon.getVertexCount();x++)
	{
		var latlng = polygon.getVertex(x);	
		arrPointsJSON.push(new Array(latlng.lng(),latlng.lat()));
	}
	
	return arrPointsJSON.toJSON();	
}

function initMapandCenter()
{
	map = new GMap2($("map_canvas"));
	if (sGeobytesLatitude.empty())
		sGeobytesLatitude=41.882047
	if (sGeobytesLongitude.empty())
		sGeobytesLongitude=-87.627916 
	map.setCenter(new GLatLng(sGeobytesLatitude,sGeobytesLongitude), 13);
}

function initMapControls()
{
	gLargeMapControl = new GLargeMapControl();
    map.addControl(gLargeMapControl);
	var mapControl = new GMapTypeControl();
	map.addControl(mapControl);
	map.enableDragging();
}

function initPolygon()
{
	prizearea = new GPolygon(map.getCenter(),'#0000FF','5','1','#0000FF','0.2');
    map.addOverlay(prizearea);
    prizearea.enableDrawing();
    GEvent.addListener(prizearea,"endline",onPolygonComplete);
}

function initFormControls()
{
	$("buttonClearShape").hide();
	$("buttonEditShape").hide();
	$("search_box").show();
	$("search_submit_button").show();
}

function initialize()
{
   	if (GBrowserIsCompatible())
   	{
		initMapandCenter();	   
		initMapControls();
		initPolygon();
		initFormControls();
	}
}

function onPolygonComplete()
{
	map.removeControl(gLargeMapControl);
	map.disableDragging();
	
	$("buttonClearShape").show();
	$("buttonEditShape").show();
	$("search_box").hide();
	$("search_submit_button").hide();
	
	disablePolygonEditing();
}

function clearPolygon()
{
	map.removeOverlay(prizearea);
	prizearea=null;
	initMapControls();
	initPolygon();
	initFormControls();
}

function enablePolygonEditing()
{
	prizearea.enableEditing();
	$("buttonEditShape").value="Save Shape";
	$("buttonEditShape").onclick = disablePolygonEditing;
}

function disablePolygonEditing()
{
	prizearea.disableEditing();
	$("buttonEditShape").value="Edit Shape";
	$("buttonEditShape").onclick = enablePolygonEditing;
}

function showAddress(address)
{
	var geocoder = new GClientGeocoder();	
	
	geocoder.getLatLng(address,
	function(point) 
	{
		if (!point) {alert(address + " not found");} 
		else {map.setCenter(point, 13);
		var marker = new GMarker(point);
		map.addOverlay(marker);
		marker.openInfoWindowHtml(address);
		} 
	})
}

function showStubAddress(address)
{
	var geocoder = new GClientGeocoder();	
	
	geocoder.getLatLng(address,
	function(point) 
	{
		if (!point) {alert(address + " not found");} 
		else {map.setCenter(point, 13);
		marker.setLatLng(point);
		} 
	})
}
