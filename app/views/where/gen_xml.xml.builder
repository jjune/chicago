#xml.instruct! :xml, :version => "1.0" LEAVE THIS COMMENTED OUT FOR WHERE PLATFORM!!!

xml.jin(:cache=>"false") do

xml.script do

xml.text! "addTrigger('menu', checkShowPopup(), 'back', checkHidePopup());"
xml.text! "function checkShowPopup() {"
xml.text! "	if (isPopupVisible()){"
xml.text! "		doHidePopup();}"
xml.text! "	else{ doShowPopup(); }"
xml.text! "}"

xml.text! "function checkHidePopup(){"
xml.text! "	if (isPopupVisible()) {"
xml.text! "		doHidePopup();}"
xml.text! "	else { back();}"
xml.text! "}"

xml.text! "function doTriggerSetup() {"
xml.text! "addTrigger('menu', doShowPopup());"
xml.text! "}"

#xml.text! "function addapoint() {"
#xml.text! "              var formObj = document.addapoint;"
#xml.text! "              formObj.submit();"
#xml.text! "}"

#xml.text! "function sliceprefs() {"
#xml.text! "              var formObj = document.mapisliceprefs;"
#xml.text! "              formObj.submit();"
#xml.text! "}"

xml.text! "function doShowPopup() {"
xml.text! "	transparencyOn(0x99000000);"
xml.text! "	document.rightCmd.src = 'http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/widget_selected.png';"
xml.text! "	document.leftCmd.src = 'http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/back_selected.png';"
xml.text! "	document.rightCmd.onSelect = 'doHidePopup()';"
xml.text! "	document.leftCmd.onSelect = 'doHidePopup()';"
xml.text! "	showPopup();"
xml.text! "}"

xml.text! "function doHidePopup() {"
xml.text! "	transparencyOff();"
xml.text! "	document.rightCmd.src = 'http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/widget.png';"
xml.text! "	document.leftCmd.src = 'http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/back.png';"
xml.text! "	document.rightCmd.onSelect = 'doShowPopup()';"
xml.text! "	document.leftCmd.onSelect = 'back()';"
xml.text! "	hidePopup();"
xml.text! "}"

end #script

xml.form(:id=>"addapoint", :action=>"http://www.mapicurious.com/maps/mapsearch.nsf/addapoint.jin?openpage", :method=>"GET")
xml.form(:id=>"mapisliceprefs", :action=>"http://www.mapicurious.com/maps/mapsearch.nsf/mapislices.jin?openpage", :method=>"GET")

xml.body(:bg=>"0xAFCAE5", :fontSize=>@textsize, :fontstyle=>"plain", :fullScreen=>"true", :onLoad=>"doTriggerSetup();") do

xml.header do
xml.img(:src=>"http://www.mapicurious.com/maps/where.nsf/mapicuriositiesheader.png?open", :align=>"center", :valign=>"center", :bg=>"0xF27E1F")	
end #header


xml.pop(:id=>"pop", :fontSize=>@textsize, :align=>"left", :valign=>"bottom", :sliding=>"up") do
xml.pr(:height=>"1") do
xml.img(:src=>"http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/h_spacer.png")
end

xml.pr do
xml.list(:id=>"popList", :border=>"0", :fg=>"0xFFFFFF", :fgfocus=>"0xCF5719", :bgfocusimg=>"http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/over_bg_menu.png", :bg=>"0x000000") do


xml.listitem(:onSelect=>"addapoint();doHidePopup();") do
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
xml.img(:src=>"http://www.where.com/images/dd/mobile/sm_widget.png")
xml.text "Add A Point (Quick Form)"
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")

xml.selected do
xml.listitem do
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
xml.img(:src=>"http://www.where.com/images/dd/mobile/sm_widget.png")
xml.text "Add A Point (Quick Form)"
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
end #listitem
end #selected
end #listitem 

xml.listitem(:onSelect=>"sliceprefs();doHidePopup();") do
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
xml.img(:src=>"http://www.where.com/images/dd/mobile/sm_widget.png")
xml.text "Search Preferences"
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")

xml.selected do
xml.listitem do
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
xml.img(:src=>"http://www.where.com/images/dd/mobile/sm_widget.png")
xml.text "Search Preferences"
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
end #listitem
end #selected
end #listitem

xml.listitem(:onSelect=>"doshowLayer();doHidePopup();") do
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
xml.img(:src=>"http://www.where.com/images/dd/mobile/sm_widget.png")
xml.text "About Mapicurious"
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")

xml.selected do
xml.listitem do
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
xml.img(:src=>"http://www.where.com/images/dd/mobile/sm_widget.png")
xml.text "About Mapicurious"
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
end #listitem
end #selected
end #listitem

xml.listitem(:onSelect=>"home();doHidePopup();") do
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
xml.img(:src=>"http://www.where.com/images/dd/mobile/sm_widget.png")
xml.text "WHERE Home"
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")

xml.selected do
xml.listitem do
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
xml.img(:src=>"http://www.where.com/images/dd/mobile/sm_widget.png")
xml.text "WHERE Home"
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
end #listitem
end #selected
end #listitem 


end #list
end #pr
end #pop

xml.pr do
xml.text("Mapicuriosities Around You", :align=>"center", :valign=>"center") 
end #pr

xml.pr do
xml.text("Add A Point to Mapicurious.com", :align=>"center", :valign=>"center") 
end #pr

xml.pr do
xml.input(:type=>"button", :value=>"Add A Point", :onSelect=>"addapoint();", :align=>"center", :valign=>"center", :fgfocus=>"0xFFFFFF", :bgfocus=>"0xF27E1F")
end #pr

xml.pr do
xml.text("Blackberry Users:", :align=>"center", :valign=>"center") 
end #pr

xml.pr do
xml.text("Use your menu and back keys to access options and navigate.", :align=>"center", :valign=>"center") 
end #pr


for prize in @prizes
	xml.pr do
		xml.text prize.name
	end
end


if @device.carrier = "Blackberry" || @device.device = "Blackberry"
xml.footer(:bgImg=>"http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/where_banner.png")
else
xml.footer do
xml.img(:id=>"rightCmd", :src=>"http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/widget.png", :onSelect=>"doShowPopup();", :bgfocusimg=>"http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/widget_selected.png")
xml.img(:id=>"leftCmd", :src=>"http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/back.png", :onSelect=>"home();")
end #footer
end

end #body

end #jin



