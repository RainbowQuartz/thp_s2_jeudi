require 'rubygems'
require 'nokogiri'
require 'open-uri'

def crypto
  hash = {}
  list_names = []
  list_values = []
  doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  doc.xpath('//a[@class = "currency-name-container link-secondary"]').each do |node|
    list_names << node.text
  end
  doc.xpath('//a[@class = "price"]').each do |node|
    list_values << node.text
  end
  for i in (0..list_names.length-1) do
    hash[list_names[i]] = list_values[i]
  end
  return hash
end

def perform
  loop do
    values = []
    crypto.each do |key, value|
      values << "value of #{key} => #{value}"
    end

    fname = "crypto_values.txt"
  	somefile = File.open(fname,"w")
  	somefile.puts(values)
  	somefile.close

    sleep 600
  end
end

perform
