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

xml.text! "function doSSLHome() {"
xml.text! "              var formObj = document.sslhome;"
xml.text! "              formObj.submit();"
xml.text! "}"

xml.text! "function doAbout() {"
xml.text! "              var formObj = document.aboutssl;"
xml.text! "              formObj.submit();"
xml.text! "}"

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

xml.form(:id=>"sslhome", :action=>"http://chicago.supersecretlabs.com/where/widget", :method=>"GET")
xml.form(:id=>"aboutssl", :action=>"http://chicago.supersecretlabs.com/where/aboutus", :method=>"GET")

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


xml.listitem(:onSelect=>"doSSLHome();doHidePopup();") do
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
xml.img(:src=>"http://www.where.com/images/dd/mobile/sm_widget.png")
xml.text "Back to Supersecret Labs"
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")

xml.selected do
xml.listitem do
xml.img(:src=>"http://www.where.com/images/dd/mobile/spacer.png")
xml.img(:src=>"http://www.where.com/images/dd/mobile/sm_widget.png")
xml.text "Back to Supersecret Labs"
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
xml.text(:"&br;", :align=>"center", :valign=>"center") 
end #pr

xml.pr do
xml.text(@headline, :align=>"center", :valign=>"center") 
end #pr

xml.pr do
xml.text(:"&br;", :align=>"center", :valign=>"center") 
end #pr

xml.pr do
xml.text(@playermsg, :align=>"center", :valign=>"center") 
end #pr

xml.pr do
xml.text(:"&br;", :align=>"center", :valign=>"center") 
end #pr

xml.pr do
xml.text(@standardclaimmsg, :align=>"center", :valign=>"center") 
end #pr

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
xml.img(:id=>"leftCmd", :src=>"http://www.where.com/images/dd/mobile/"+ @device.screenwidth + "/back.png", :onSelect=>"back();")
end #footer
end

end #body

end #jin



