require 'nokogiri'
require 'pry'

class Document
	def initialize(url, content)
		@url = url
		@content = content
	end

	def hrefs
		@hrefs ||= links.map { |link| link['href'] }.uniq
	end

	private

	def parsed
		@parsed ||= Nokogiri::HTML(@content)
	end

	def links
		@links ||= parsed.css('a')
	end
end

