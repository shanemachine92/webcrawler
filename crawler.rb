require 'pry'
require 'set'
require 'JSON'
require 'nokogiri'
require 'open-uri'
require_relative './document'
require_relative './url_fetcher'

class Crawler
  attr_accessor :url, :href, :db
  def initialize(db)
    @database = db 
  end

  def done_crawling?
    @database.execute( "SELECT count(*) FROM URLS_to_crawl WHERE state = 'uncrawled'" )[0][0] == 0
  end

  def crawl_next_url
    begin
      url = @database.execute( "SELECT url FROM URLS_to_crawl WHERE state = 'uncrawled' LIMIT 1" )[0][0]
      content = UrlFetcher.fetch(url)
      document = Document.new(url, content)
      write_documents_to_db(document)
      document.domain_hrefs.each do |href|
        write_urls_to_db(href)
      end
      update_state(url)
    rescue => e
      puts "#{e} #{url}"
      update_state_for_error(url)
    end
  end

  def update_state(url)
    @database.execute( "UPDATE URLS_to_crawl SET state = 'crawled' WHERE url = ?", [url] )
  end

  def update_state_for_error(url)
    @database.execute( "UPDATE URLS_to_crawl SET state = 'error' WHERE url = ?", [url] )
  end

  def write_urls_to_db(url)
    @database.execute("INSERT OR IGNORE INTO URLS_to_crawl (url, state) 
                VALUES (?, 'uncrawled')", ['http://dragonage.wikia.com' + url])
  end  

  def write_documents_to_db(document)
    url = @database.execute( "SELECT url FROM URLS_to_crawl WHERE state = 'uncrawled' LIMIT 1" )[0][0]
    content = UrlFetcher.fetch(url)
    @database.execute("INSERT OR IGNORE INTO documents (url, content) 
                VALUES (?, ?)", [url, content])
  end

  def run
    if done_crawling?
      puts "Crawling complete!"
      exit 0
    end
    crawl_next_url
  end
end
