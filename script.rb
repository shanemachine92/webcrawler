require 'pry'
require 'sqlite3'
require_relative './crawler'
require_relative 'document_collection'

db = SQLite3::Database.new 'webcrawler.db'

db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS URLS_to_crawl (
    url varchar(200),
    state varchar(25)
  );
SQL

db.execute("INSERT OR IGNORE INTO URLS_to_crawl (url, state) VALUES ('http://dragonage.wikia.com', 'uncrawled')")

db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS documents (
    url varchar(200),
    content varchar(65535)
  );
SQL

document_collection = DocumentCollection.new
crawler = Crawler.new(document_collection, db)

loop do 
  crawler.run
end
