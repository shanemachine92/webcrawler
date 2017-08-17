require 'pry'
require 'set'
require 'JSON'
require 'nokogiri'
require 'open-uri'
require_relative './document'
require_relative './url_fetcher'
require_relative './document_collection'

class Crawler
  attr_accessor :url, :href, :db
  def initialize(document_collection, url_collection, db)
    @document_collection = document_collection
    @url_collection = url_collection
    @set = Set.new
    @database = db 
  end

  def done_crawling?
    @url_collection.empty?
  end

  def crawl_next_url
    url = @url_collection.next_url
    state = "uncrawled"
    content = UrlFetcher.fetch(url)
    document = Document.new(url, content)
    @document_collection.add_document(document)
    puts document.domain_hrefs.take(5)
    document.domain_hrefs.each do |href|
      next if already_crawled?(href)
      @url_collection.add_url(href)
      track_url(href)
      write_to_db
      update_state
    end
  end

  def update_state
    state = "crawled"
  end

  def already_crawled?(url)
    @set.include?(url)
  end

  def track_url(url)
    @set.add(url)
  end

  def write_to_db(url, state)
    @database.execute("INSERT INTO URLS_to_crawl (url, state) 
                VALUES (?, ?)", [url, state])

    @database.execute( "select * from URLS_to_crawl" ) do |row|
      p row
    end
  end

  def run
    begin
      if done_crawling?
        puts "Crawling complete!"
        exit 0
      end
      crawl_next_url
    rescue OpenURI::HTTPError=>e
      puts "Error: #{e}"
    end
  end
end
