require 'nokogiri'
require 'pry'

class Document
	def initialize(url, content)
		@url = url
		@content = content
	end

	def domain_hrefs
		@domain_hrefs ||= hrefs.grep (/^\/wiki\//)
	end

	private

	def hrefs
		@hrefs ||= links.map { |link| link['href'] }.uniq
	end

	def parsed
		@parsed ||= Nokogiri::HTML(@content)
	end

	def links
		@links ||= parsed.css('a')
	end
end

