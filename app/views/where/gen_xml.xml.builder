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

#xml.text! "function doSnoop() {"
#xml.text! "              var formObj = document.snoop;"
#xml.text! "              formObj.submit();"
#xml.text! "}"

#xml.text! "function doAbout() {"
#xml.text! "              var formObj = document.aboutssl;"
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

xml.form(:id=>"snoop", :action=>"http://www.mapicurious.com/maps/mapsearch.nsf/addapoint.jin?openpage", :method=>"GET")
xml.form(:id=>"aboutssl", :action=>"http://www.mapicurious.com/maps/mapsearch.nsf/mapislices.jin?openpage", :method=>"GET")

xml.body(:bg=>"0xFFFFFF", :fontSize=>@textsize, :fontstyle=>"plain", :fullScreen=>"true", :onLoad=>"doTriggerSetup();") do

xml.header do
xml.img(:src=>"http://chicago.supersecretlabs.com/images/logo_small.png", :align=>"center", :valign=>"center", :bg=>"0xFFFFFF")	
end #header


xml.pop(:id=>"pop", :fontSize=>@textsize, :align=>"left", :valign=>"bottom", :sliding=>"up") do
xml.pr(:height=>"1") do
xml.img(:src=>"http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/h_spacer.png")
end

xml.pr do
xml.list(:id=>"popList", :border=>"0", :fg=>"0xFFFFFF", :fgfocus=>"0xCF5719", :bgfocusimg=>"http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/over_bg_menu.png", :bg=>"0x000000") do


xml.listitem(:onSelect=>"doSnoop();doHidePopup();") do
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
xml.img(:src=>"http://www.where.com/images/dd/mobile/sm_widget.png")
xml.text "Snoop for Loot"
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")

xml.selected do
xml.listitem do
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
xml.img(:src=>"http://www.where.com/images/dd/mobile/sm_widget.png")
xml.text "Snoop for Loot"
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
end #listitem
end #selected
end #listitem 

xml.listitem(:onSelect=>"doAbout();doHidePopup();") do
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
xml.img(:src=>"http://www.where.com/images/dd/mobile/sm_widget.png")
xml.text "About SuperSecretLabs"
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")

xml.selected do
xml.listitem do
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
xml.img(:src=>"http://www.where.com/images/dd/mobile/sm_widget.png")
xml.text "About SuperSecretLabs"
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
xml.text("Our satellites see you here:", :align=>"center", :valign=>"center") 
end #pr

xml.pr do
xml.img(:src=>:"http://maps.google.com/staticmap?center=33.84275,-84.49008&zoom=14&size=" + @device.screenwidth + "x128&maptype=mobile&markers=33.84275,-84.49008,blue&format=png&key=ABQIAAAA6RZP3ZouLBJsRfEv4s3jzhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxT6qAbsBjBmEKqdpIQq_13niSn_-Q", :align=>"center", :valign=>"center", :bg=>"0xF27E1F")	
end #pr

xml.pr do
xml.text("Are you near the money?", :align=>"center", :valign=>"center") 
end #pr

xml.pr do
xml.input(:type=>"button", :value=>"Snoop for Loot", :onSelect=>"doSnoop();", :align=>"center", :valign=>"center", :fgfocus=>"0x000000", :bgfocus=>"0xFFFFFF")
end #pr

#This could be taken out in live app
for prize in @prizes
	xml.pr do
		xml.text prize.name
	end
end

if @device.carrier.include? "Blackberry" then

xml.pr do
xml.text("Blackberry Users:", :align=>"center", :valign=>"center") 
end #pr

xml.pr do
xml.text("Use your menu and back keys to access options and navigate.", :align=>"center", :valign=>"center") 
end #pr

xml.footer(:bgImg=>"http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/where_banner.png")
else
xml.footer do
xml.img(:id=>"rightCmd", :src=>"http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/widget.png", :onSelect=>"doShowPopup();", :bgfocusimg=>"http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/widget_selected.png")
xml.img(:id=>"leftCmd", :src=>"http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/back.png", :onSelect=>"home();")
end #footer
end

end #body

end #jin



