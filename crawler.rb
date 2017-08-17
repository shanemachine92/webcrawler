require 'pry'
require 'set'
require 'JSON'
require 'nokogiri'
require 'open-uri'
require_relative './document'
require_relative './url_fetcher'

class Crawler
  attr_accessor :url, :href, :db
  def initialize(document_collection, db)
    @document_collection = document_collection
    @set = Set.new
    @database = db 
  end

  def done_crawling?
    @database.execute( "SELECT count(*) FROM URLS_to_crawl WHERE state = 'uncrawled'" )[0][0] == 0
  end

  def crawl_next_url
    url = @database.execute( "SELECT url FROM URLS_to_crawl WHERE state = 'uncrawled' LIMIT 1" )[0][0]
    content = UrlFetcher.fetch(url)
    document = Document.new(url, content)
    @document_collection.add_document(document)
    puts document.domain_hrefs.take(5)
    document.domain_hrefs.each do |href|
      next if already_crawled?(href)
      write_to_db(href)
    end
    update_state(url)
  end

  def update_state(url)
    @database.execute( "UPDATE URLS_to_crawl SET state = 'crawled' WHERE url = ?", [url] )
  end

  def update_state_for_error(url)
    @database.execute( "UPDATE URLS_to_crawl SET state = 'error' WHERE url = ?", [url] )
  end

  def already_crawled?(url)
    @set.include?(url)
  end

  def track_url(url)
    @set.add(url)
  end

  def write_to_db(url)
    @database.execute("INSERT INTO URLS_to_crawl (url, state) 
                VALUES (?, 'uncrawled')", [url])

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
    rescue =>e
      update_state_for_error(url)
    end
  end
end
