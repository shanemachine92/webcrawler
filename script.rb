require 'pry'
require_relative './crawler'
require_relative './document_collection'
require_relative './url_collection'

BASE_URL = 'http://dragonage.wikia.com/'
document_collection = DocumentCollection.new
url_collection = UrlCollection.new
url_collection.add_url(BASE_URL)
crawler = Crawler.new(document_collection, url_collection)

crawler.run(2)

puts document_collection.size
puts url_collection.size





