#!/Users/raknight/.rbenv/shims/ruby

## @title 				fetch-keywords.rb
## @version 			1.0
## @date 					08 May 2015
## @author 				Rob Knight
## @description		Fetches the keywords from an archive of UC Santa Cruz
## 								news articles. 
## @param					year (4-digit string; ex: "2010")

require "open-uri"
require "nokogiri"
require "uri"

BASE_URL = "http://news.ucsc.edu"
months = ["01","02","03","04","05","06","07","08","09","10","11","12"]

query = ARGV[0]
query = "2010" unless query

def fetch_month_archive(year, month)
	url = "#{BASE_URL}/#{year}/#{month}/"
	page = Nokogiri::HTML(open(url))
	articles = page.css('.archive-list li h3 a')
	articles.each do |article|
		link = "#{url}#{article['href']}"
		print fetch_keywords(link)
	end
end

def fetch_keywords(link)
	set = []
	page = Nokogiri::HTML(open(URI.escape(link)))
	keywords = page.css('meta').select{|tag| tag['name'] == "keywords"}
	if keywords.length > 0
		keywords.each do |keyword|
			result = keyword['content'].gsub(/(?i)(ucsc|uc santa cruz|uc|university of california| santa cruz)(,|\b)/m, "")
			set.push "#{result}, "
		end
		return set.join("\n").strip
	else
		return
	end
end

months.each do |m|
	fetch_month_archive(query, m)
end
