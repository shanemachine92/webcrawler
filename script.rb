require 'pry'
require 'sqlite3'
require_relative './crawler'

db = SQLite3::Database.new 'webcrawler.db'

db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS URLS_to_crawl (
    url varchar(200) PRIMARY KEY,
    state varchar(25)
  );
SQL

db.execute("INSERT OR IGNORE INTO URLS_to_crawl (url, state) VALUES ('http://dragonage.wikia.com', 'uncrawled')")

db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS documents (
    url varchar(200) PRIMARY KEY,
    content varchar(65535)
  );
SQL

crawler = Crawler.new(db)

loop do 
  crawler.run
  puts "crawling..."
end
