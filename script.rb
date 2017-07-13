require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './document'
require_relative './crawler'

Crawler.new.get_links
