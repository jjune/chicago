xml.instruct! :xml, :version => "1.0"

xml.rss(:version=>"2.0") do

xml.channel do
xml.description #required
xml.link #required http://chicago.supersecretlabs.com
xml.title #required
          

xml.category
xml.cloud
xml.copyright #super secret labs
xml.docs
xml.generator
xml.image do
	xml.link
	xml.title
	xml.url
	xml.description
	xml.height
	xml.width
end #image

xml.language
xml.lastBuildDate
xml.managingEditor
xml.pubDate
xml.rating

xml.skipDays do
xml.day
end

xml.skipHours do
xml.hour
end

xml.textInput do
xml.description
xml.link
xml.name
xml.title
end

xml.ttl
xml.webMaster

xml.item do
xml.author
xml.category
xml.comments
xml.description
xml.enclosure
xml.guid
xml.link
xml.pubDate
xml.source
xml.title
end

end #rss