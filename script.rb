require 'pry'
require_relative './crawler'
require_relative './document_collection'
require_relative './breadth_first_url_collection'
require_relative './depth_first_url_collection'

BASE_URL = 'http://dragonage.wikia.com'

document_collection = DocumentCollection.new
url_collection = DepthFirstUrlCollection.new
url_collection.add_url('')
crawler = Crawler.new(document_collection, url_collection)

loop do 
  crawler.run
end
