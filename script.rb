require 'pry'
require_relative './crawler'
require_relative './document_collection'
require_relative './url_collection'

document_collection = DocumentCollection.new
url_collection = UrlCollection.new
url_collection.add_url('http://dragonage.wikia.com/')
crawler = Crawler.new(document_collection, url_collection)

crawler.run(3)

puts document_collection.size
puts url_collection.size





