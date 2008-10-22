document.write("<script language='Javascript' src='http://gd.geobytes.com/gd?after=-1&variables=GeobytesCountry,GeobytesCity,GeobytesRegion,GeobytesLatitude,GeobytesLongitude' ></script>");
    var map = null;
 	var geocoder = null;
 	var prizearea = null;


	function whereami()
   {   
    alert(map.getBounds());
    alert(map.getCenter());  
   }

   function doStuffBeforeSubmit()
   {
   var arrTempPrizeArea=new Array();
   for (var x=0;x<prizearea.getVertexCount();x++){
   	var latlng = prizearea.getVertex(x);
 		arrTempPrizeArea.push(latlng.lat()+","+latlng.lng());
		}

		strTempGeo = arrTempPrizeArea.join(":")
	 	document.getElementById("prize_prizearea").value = strTempGeo;
	 	document.getElementById("center_lat").value = map.getCenter().lat();
	 	document.getElementById("center_lng").value = map.getCenter().lng();
}
 function whereistheprizearea()
 {
 	//alert(prizearea.getBounds())
 	//alert(prizearea.getArea())
 	alert("vertex count:"+prizearea.getVertexCount())
		prizearea.enableEditing()
	}

 function initialize() {
   if (GBrowserIsCompatible()) {
    map = new GMap2(document.getElementById("map_canvas"));
    //map.setCenter(new GLatLng(37.4419, -122.1419), 13);
	map.setCenter(new GLatLng(sGeobytesLatitude,sGeobytesLongitude), 13);
    map.addControl(new GLargeMapControl());
	var mapControl = new GMapTypeControl();
	map.addControl(mapControl);

	//map.enableContinuousZoom();
    //map.disableDragging();
	//map.addControl(GSmallZoomControl());
	//map.GMenuMapTypeControl(true);
    prizearea = new GPolygon(map.getCenter(),'#0000FF','5','1','#0000FF','0.2');
    map.addOverlay(prizearea);
    prizearea.enableDrawing();
    //GEvent.addListener(map, "moveend", function(){whereami(map);});
    geocoder = new GClientGeocoder();

   }
 }

 function showAddress(address) {
   if (geocoder) {
     geocoder.getLatLng(
       address,
       function(point) {
         if (!point) {
           alert(address + " not found");
         } else {
           map.setCenter(point, 13);
           var marker = new GMarker(point);
           map.addOverlay(marker);
           marker.openInfoWindowHtml(address);
            prizearea = new GPolygon(map.getCenter(),'#0000FF','5','1','#0000FF','0.2');
     map.addOverlay(prizearea);
     prizearea.enableDrawing(); 
         }
       }
     )
   }
 }