require 'pry'
require 'set'
require 'JSON'
require 'nokogiri'
require 'open-uri'
require_relative './document'
require_relative './url_fetcher'

class Crawler
  attr_accessor :url, :href, :connection
  def initialize(connection)
    @connection = connection 
  end

  def done_crawling?
    @connection.execute("SELECT count(*) FROM URLS_to_crawl WHERE state = 'uncrawled'")[0][0] == 0
  end

  def crawl_next_url
    begin
      @connection.transaction
      url = @connection.execute("SELECT url FROM URLS_to_crawl WHERE state = 'uncrawled' LIMIT 1")[0][0]
      content = UrlFetcher.fetch(url)
      document = Document.new(url, content)
      get_url_and_write_document(document)
      document.domain_hrefs.each { |href| write_urls_to_database(href) }
      update_state(url)
      @connection.commit
    rescue StandardError, SQLite3::Exception => e
      puts "#{e} #{url}"
      update_state_for_error(url)
      @connection.rollback
    end
  end

  def update_state(url)
    @connection.execute("UPDATE URLS_to_crawl SET state = 'crawled' WHERE url = ?", [url])
  end

  def update_state_for_error(url)
    @connection.execute("UPDATE URLS_to_crawl SET state = 'error' WHERE url = ?", [url])
  end

  def write_urls_to_database(url)
    @connection.execute("INSERT OR IGNORE INTO URLS_to_crawl (url, state) 
                VALUES (?, 'uncrawled')", ['http://dragonage.wikia.com' + url])
  end  

  def get_url_and_write_document(document)
    url = @connection.execute("SELECT url FROM URLS_to_crawl WHERE state = 'uncrawled' LIMIT 1")[0][0]
    content = UrlFetcher.fetch(url)
    @connection.execute("INSERT INTO documents (url, content) 
                VALUES (?, ?)", [url, content])
  end

  def run
    if done_crawling?
      puts "Crawling complete!"
      %x(/usr/local/bin/terminal-notifier -message "Total Documents: #{@connection.execute("SELECT COUNT(*) FROM documents")}" -title "Crawling Complete!")
      exit 0
    end
    crawl_next_url
  end
end
