require 'pry'
require 'sqlite3'
require_relative './crawler'

connection = SQLite3::Database.new 'webcrawler.db'

connection.execute <<-SQL
  CREATE TABLE IF NOT EXISTS URLS_to_crawl (
    url TEXT PRIMARY KEY,
    state varchar(10)
  );
SQL

connection.execute("INSERT OR IGNORE INTO URLS_to_crawl (url, state) VALUES ('http://dragonage.wikia.com', 'uncrawled')")

connection.execute <<-SQL
  CREATE TABLE IF NOT EXISTS documents (
    url TEXT PRIMARY KEY,
    content TEXT
  );
SQL

crawler = Crawler.new(connection)

loop do 
  crawler.run
  puts "crawling..."
end
