xml.instruct! :xml, :version => "1.0"

xml.jin do

xml.pr do
xml.text "Congratulations"
end

    xml.title "My Feed"
	xml.link "http://www.myfeed.com"
   	xml.description "This is my feed"
     
     for prize in @prizes
       xml.prize do
         xml.title prize.name
         xml.link "http://www.myfeed.com"
       end

     end

 end





