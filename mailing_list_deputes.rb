require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def depute_list
  mp_list = []
  doc = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))
  doc.xpath('//td/a').each do |node|
    mp_list << node['href']
  end
  return mp_list
end

def coordonne_depute(urls)
  list = []
  urls.each do |url|
    hash = {}
    url = "https://www.nosdeputes.fr#{url}"
    doc = Nokogiri::HTML(open("#{url}"))
    hash[:names] = doc.xpath('//h1').text
    hash[:emails] = doc.xpath('/html/body/div[1]/div[5]/div/div[2]/div[1]/ul[2]/li[1]/ul/li[1]/a').text
    list << hash
  end
  return list
end

def perform
  list = coordonne_depute(depute_list)

  fname = "mailing_list_depute.txt"
	somefile = File.open(fname,"w")
	somefile.puts(list)
	somefile.close
end

perform
