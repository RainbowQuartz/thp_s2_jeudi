require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_the_email_of_a_townhal_from_its_webpage(urls)
  list = []
  urls.each do |url|
    hash ={}
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com#{url[1..-1]}"))
    hash[:name] = doc.xpath('/html/body/div/main/section[1]/div/div/div/h1').text
    hash[:email] = doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    list << hash
  end
  return list
end

def get_all_the_urls_of_val_doise_townhalls
  urls = []
  doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  	doc.xpath('//a[@class = "lientxt"]').each do |node|
  	  urls << node['href']
  	end
  return urls
end

def perform
  hash = get_the_email_of_a_townhal_from_its_webpage(get_all_the_urls_of_val_doise_townhalls)

  fname = "mailing_list_mairies.txt"
  somefile = File.open(fname,"w")
  somefile.puts(hash)
  somefile.close
end

perform
