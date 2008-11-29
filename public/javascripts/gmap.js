//Initialize a lat lng from a user's IP to decide where to start the map
document.write("<script language='Javascript' src='http://gd.geobytes.com/gd?after=-1&variables=GeobytesCountry,GeobytesCity,GeobytesRegion,GeobytesLatitude,GeobytesLongitude' ></script>");

var map = null;
var prizearea = null;
var gLargeMapControl=null;
var polygonEditMode = "show";

function doStuffBeforeSubmit()
{
	document.getElementById("prize_prizearea").value = gPolygonToJSON(prizearea);
	document.getElementById("zoom").value = map.getZoom();
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
	map = new GMap2(document.getElementById("map_canvas"));
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
	document.getElementById("buttonClearShape").style.display="none";
	document.getElementById("buttonEditShape").style.display="none";
	document.getElementById("search_box").style.display="";
	document.getElementById("search_submit_button").style.display="";
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
	
	document.getElementById("buttonClearShape").style.display="";
	document.getElementById("buttonEditShape").style.display="";
	document.getElementById("search_box").style.display="none";
	document.getElementById("search_submit_button").style.display="none";
}

function clearPolygon()
{
	map.removeOverlay(prizearea);
	prizearea=null;
	initMapControls();
	initPolygon();
	initFormControls();
}

function swapPolygonEditing()
{
	if(polygonEditMode=="show")
	{
		prizearea.enableEditing();
		polygonEditMode="edit"
		document.getElementById("buttonEditShape").value="Save Shape";
	}
	else
	{
		prizearea.disableEditing();
		polygonEditMode="show";
		document.getElementById("buttonEditShape").value="Edit Shape";
	}
}