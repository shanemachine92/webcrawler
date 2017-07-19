require 'nokogiri'
require 'open-uri'
require 'JSON'
require 'pry'

class DocumentCollection
	def initialize
		@arr = []
	end

	def add_document(document)
		@arr << document
	end

	def size
		@arr.size
	end

	def [](key)
		@arr[key]
	end
end
